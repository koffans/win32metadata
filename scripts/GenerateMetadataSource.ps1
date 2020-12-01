
param
(
    [string]
    $artifactsDir,

    [string]
    $pipelineRunName,

    [bool]
    $downloadDefaultCppNugets = $true,

    [string]
    $patch = ""
)

. "$PSScriptRoot\CommonUtils.ps1"

if (!$pipelineRunName)
{
    $pipelineRunName = $defaultWinSDKNugetVersion.Substring("10.0.".Length) + ".branchname.date-time"
}

function Download-Nupkg
{
    Param ([string] $name, [string] $version, [string] $outputDir)

    $url = "https://www.nuget.org/api/v2/package/$name/$version"
    $output = "$outputDir\$name.$version.nupkg"

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $output)
}

function Replace-Text
{
    Param ([string] $path, [hashtable] $items)

    $content = Get-Content -path $path -Encoding UTF8
    foreach ($key in $items.Keys)
    {
        $content = $content.Replace($key, $items[$key]);
    }
    
    Set-Content -path $path -Encoding UTF8 -value $content
}

if (!$artifactsDir)
{
    $artifactsDir = "$rootDir\artifacts"
    Create-Directory $artifactsDir
}

Write-Host "Making sure cpp NuGet packages are installed..."

$nugetSrcPackagesDir = Join-Path -Path $artifactsDir "NuGetPackages"
Create-Directory $nugetSrcPackagesDir

$parts = $pipelineRunName.Split("{.}")
$build = $parts[0]
$qfe = $parts[1]
$branch = $parts[2].Replace("_", "-")
$potentialVersions = "10.0.$build.$qfe-preview.$branch", "10.0.$build.$qfe-preview", "10.0.$build.$qfe"
$version = $null

foreach ($ver in $potentialVersions)
{
    Write-Host "Looking for: $nugetSrcPackagesDir\Microsoft.Windows.SDK.CPP.$ver.nupkg..."
    $cppPkg = Get-ChildItem -path $nugetSrcPackagesDir -Include Microsoft.Windows.SDK.CPP.$ver.nupkg -recurse
    if ($cppPkg)
    {
        $version = $ver
        Write-Host "Found NuGet package, version: $version"
        break;
    }
}

if (!$version)
{
    if (!$downloadDefaultCppNugets)
    {
        Write-Host "Error: Couldn't find cpp package in $nugetSrcPackagesDir. Call script with downloadDefaultCppNugets = 1 to download default packages."
        exit -1
    }
    else
    {
        $version = $defaultWinSDKNugetVersion
        Write-Host "No cpp nuget packages found at $nugetSrcPackagesDir. Downloading $version from nuget.org..."

        Download-Nupkg "Microsoft.Windows.SDK.CPP" $version $nugetSrcPackagesDir
        Download-Nupkg "Microsoft.Windows.SDK.CPP.x64" $version $nugetSrcPackagesDir
        $cppPkg = Get-ChildItem -path $nugetSrcPackagesDir -Include Microsoft.Windows.SDK.CPP.10.*.nupkg -recurse
    }
}

$nugetSrcPackagesDir = Join-Path -Path $artifactsDir "NuGetPackages"
Create-Directory $nugetSrcPackagesDir

$publishNugetVersion = $version

# patch is an auto-increment counter specific to the pipeline name.
# If it's set...
if ($patch -ne "")
{
    # If this is a preview build, just append the patch to the end of the version
    if ($version.Contains("-preview"))
    {
        $publishNugetVersion = "$version.$patch"
    }
    # If this isn't a preview build, we want to replace the build QFE with the patch
    else
    {
        $buildParts = $version.Split("{.}")
        $qfePart = $buildParts[3]
        $qfeParts = $qfePart.Split("{-}")
        $qfe = $qfeOverride
        if ($qfeParts.Length -eq 2)
        {
            $qfeExtra = $qfeParts[1]
            $qfe = "$qfe-$qfeExtra"
        }
    
        $buildParts[3] = $patch

        $publishNugetVersion = [string]::Join(".", $buildParts)
    }
}

# Write variable in the Azure DevOps pipeline for use in subsequent tasks
Write-Host "##vso[task.setvariable variable=PrepOutput.NugetVersion;]$publishNugetVersion"

$x64Pkg = Get-ChildItem -path "$nugetSrcPackagesDir\Microsoft.Windows.SDK.CPP.x64.$version.nupkg"
if (!$x64Pkg)
{
    Write-Host "Error: Couldn't find cpp x64 package: $x64Pkg."
    exit -1
}

$nugetDestPackagesDir = Join-Path -Path $artifactsDir "InstalledPackages"
Create-Directory $nugetDestPackagesDir
& $toolsDir\nuget.exe install Microsoft.Windows.SDK.CPP.x64 -version $version -source $nugetSrcPackagesDir -OutputDirectory $nugetDestPackagesDir

Write-Host "`n`nProcessing each supported lib name...`n"

$libNames = Get-ChildItem $importLibsDir | select -ExpandProperty Name
# $libNames = @("ole32", "onecoreuap", "d3d11", "d3d12", "d3dcompiler")

foreach ($libName in $libNames)
{
    Write-Host "Calling $PSScriptRoot\GenerateMetadataSourceForLib.ps1 -version $version -libName $libName -artifactsDir $artifactsDir..."
    & $PSScriptRoot\GenerateMetadataSourceForLib.ps1 -version $version -libName $libName -artifactsDir $artifactsDir
    Write-Host
}

exit 0
