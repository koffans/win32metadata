using System;

namespace Microsoft.Windows.Sdk.Win32
{
    public static unsafe partial class Apis
    {
        public const string D3DCOMPILER_DLL = "d3dcompiler_47.dll";

        public const int D3D_COMPILER_VERSION = 47;

        public const uint D3DCOMPILE_DEBUG = 1 << 0;

        public const uint D3DCOMPILE_SKIP_VALIDATION = 1 << 1;

        public const uint D3DCOMPILE_SKIP_OPTIMIZATION = 1 << 2;

        public const uint D3DCOMPILE_PACK_MATRIX_ROW_MAJOR = 1 << 3;

        public const uint D3DCOMPILE_PACK_MATRIX_COLUMN_MAJOR = 1 << 4;

        public const uint D3DCOMPILE_PARTIAL_PRECISION = 1 << 5;

        public const uint D3DCOMPILE_FORCE_VS_SOFTWARE_NO_OPT = 1 << 6;

        public const uint D3DCOMPILE_FORCE_PS_SOFTWARE_NO_OPT = 1 << 7;

        public const uint D3DCOMPILE_NO_PRESHADER = 1 << 8;

        public const uint D3DCOMPILE_AVOID_FLOW_CONTROL = 1 << 9;

        public const uint D3DCOMPILE_PREFER_FLOW_CONTROL = 1 << 10;

        public const uint D3DCOMPILE_ENABLE_STRICTNESS = 1 << 11;

        public const uint D3DCOMPILE_ENABLE_BACKWARDS_COMPATIBILITY = 1 << 12;

        public const uint D3DCOMPILE_IEEE_STRICTNESS = 1 << 13;

        public const uint D3DCOMPILE_OPTIMIZATION_LEVEL0 = 1 << 14;

        public const uint D3DCOMPILE_OPTIMIZATION_LEVEL1 = 0;

        public const uint D3DCOMPILE_OPTIMIZATION_LEVEL2 = (1 << 14) | (1 << 15);

        public const uint D3DCOMPILE_OPTIMIZATION_LEVEL3 = 1 << 15;

        public const uint D3DCOMPILE_RESERVED16 = 1 << 16;

        public const uint D3DCOMPILE_RESERVED17 = 1 << 17;

        public const uint D3DCOMPILE_WARNINGS_ARE_ERRORS = 1 << 18;

        public const uint D3DCOMPILE_RESOURCES_MAY_ALIAS = 1 << 19;

        public const uint D3DCOMPILE_ENABLE_UNBOUNDED_DESCRIPTOR_TABLES = 1 << 20;

        public const uint D3DCOMPILE_ALL_RESOURCES_BOUND = 1 << 21;

        public const uint D3DCOMPILE_DEBUG_NAME_FOR_SOURCE = 1 << 22;

        public const uint D3DCOMPILE_DEBUG_NAME_FOR_BINARY = 1 << 23;

        public const uint D3DCOMPILE_EFFECT_CHILD_EFFECT = 1 << 0;

        public const uint D3DCOMPILE_EFFECT_ALLOW_SLOW_OPS = 1 << 1;

        public const uint D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_LATEST = 0;

        public const uint D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_0 = 1 << 4;

        public const uint D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_1 = 1 << 5;

        public const uint D3D_COMPILE_STANDARD_FILE_INCLUDE = 1;

        public const uint D3DCOMPILE_SECDATA_MERGE_UAV_SLOTS = 0x00000001;

        public const uint D3DCOMPILE_SECDATA_PRESERVE_TEMPLATE_SLOTS = 0x00000002;

        public const uint D3DCOMPILE_SECDATA_REQUIRE_TEMPLATE_MATCH = 0x00000004;

        public const uint D3D_DISASM_ENABLE_COLOR_CODE = 0x00000001;

        public const uint D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS = 0x00000002;

        public const uint D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING = 0x00000004;

        public const uint D3D_DISASM_ENABLE_INSTRUCTION_CYCLE = 0x00000008;

        public const uint D3D_DISASM_DISABLE_DEBUG_INFO = 0x00000010;

        public const uint D3D_DISASM_ENABLE_INSTRUCTION_OFFSET = 0x00000020;

        public const uint D3D_DISASM_INSTRUCTION_ONLY = 0x00000040;

        public const uint D3D_DISASM_PRINT_HEX_LITERALS = 0x00000080;

        public const uint D3D_GET_INST_OFFSETS_INCLUDE_NON_EXECUTABLE = 0x00000001;

        public const uint D3D_COMPRESS_SHADER_KEEP_ALL_PARTS = 0x00000001;
    }
}