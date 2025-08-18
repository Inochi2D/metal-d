/**
    MTLDataType

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.datatype;
import objc.basetypes;

/**
    An enumeration of the different data types in Metal.
*/
enum MTLDataType : NSUInteger {

    /// Represents no data type.
    None = 0,

    /// Represents a struct data type.
    Struct = 1,
    /// Represents an array data type.
    Array = 2,

    /// Represents a data type consisting of a single floating-point value.
    Float = 3,
    /// Represents a data type consisting of a vector of two floating-point values.
    Float2 = 4,
    /// Represents a data type consisting of a vector of three floating-point values.
    Float3 = 5,
    /// Represents a data type consisting of a vector of four floating-point values.
    Float4 = 6,

    /// Represents a data type consisting of a 2x2 floating-point matrix.
    Float2x2 = 7,
    /// Represents a data type consisting of a 2x3 floating-point matrix.
    Float2x3 = 8,
    /// Represents a data type consisting of a 2x4 floating-point matrix.
    Float2x4 = 9,

    /// Represents a data type consisting of a 3x2 floating-point matrix.
    Float3x2 = 10,
    /// Represents a data type consisting of a 3x3 floating-point matrix.
    Float3x3 = 11,
    /// Represents a data type consisting of a 3x4 floating-point matrix.
    Float3x4 = 12,

    /// Represents a data type consisting of a 4x2 floating-point matrix.
    Float4x2 = 13,
    /// Represents a data type consisting of a 4x3 floating-point matrix.
    Float4x3 = 14,
    /// Represents a data type consisting of a 4x4 floating-point matrix.
    Float4x4 = 15,

    /// Represents a data type consisting of a half-precision floating-point value.
    Half = 16,
    /// Represents a data type consisting of a vector of two half-precision floating-point values.
    Half2 = 17,
    /// Represents a data type consisting of a vector of three half-precision floating-point values.
    Half3 = 18,
    /// Represents a data type consisting of a vector of four half-precision floating-point values.
    Half4 = 19,

    /// Represents a data type consisting of a 2x2 half-precision floating-point matrix.
    Half2x2 = 20,
    /// Represents a data type consisting of a 2x3 half-precision floating-point matrix.
    Half2x3 = 21,
    /// Represents a data type consisting of a 2x4 half-precision floating-point matrix.
    Half2x4 = 22,

    /// Represents a data type consisting of a 3x2 half-precision floating-point matrix.
    Half3x2 = 23,
    /// Represents a data type consisting of a 3x3 half-precision floating-point matrix.
    Half3x3 = 24,
    /// Represents a data type consisting of a 3x4 half-precision floating-point matrix.
    Half3x4 = 25,

    /// Represents a data type consisting of a 4x2 half-precision floating-point matrix.
    Half4x2 = 26,
    /// Represents a data type consisting of a 4x3 half-precision floating-point matrix.
    Half4x3 = 27,
    /// Represents a data type consisting of a 4x4 half-precision floating-point matrix.
    Half4x4 = 28,

    /// Represents a data type consisting of a single signed integer value.
    Int = 29,
    /// Represents a data type consisting of a vector of two signed integer values.
    Int2 = 30,
    /// Represents a data type consisting of a vector of three signed integer values.
    Int3 = 31,
    /// Represents a data type consisting of a vector of four signed integer values.
    Int4 = 32,

    /// Represents a data type consisting of a single unsigned integer value.
    UInt = 33,
    /// Represents a data type consisting of a vector of two unsigned integer values.
    UInt2 = 34,
    /// Represents a data type consisting of a vector of three unsigned integer values.
    UInt3 = 35,
    /// Represents a data type consisting of a vector of four unsigned integer values.
    UInt4 = 36,

    /// Represents a data type consisting of a single 16-bit signed integer value.
    Short = 37,
    /// Represents a data type consisting of a vector of two 16-bit signed integer values.
    Short2 = 38,
    /// Represents a data type consisting of a vector of three 16-bit signed integer values.
    Short3 = 39,
    /// Represents a data type consisting of a vector of three 16-bit signed integer values.
    Short4 = 40,

    /// Represents a data type consisting of a single 16-bit unsigned integer value.
    UShort = 41,
    /// Represents a data type consisting of a vector of two 16-bit unsigned integer values.
    UShort2 = 42,
    /// Represents a data type consisting of a vector of three 16-bit unsigned integer values.
    UShort3 = 43,
    /// Represents a data type consisting of a vector of four 16-bit unsigned integer values.
    UShort4 = 44,

    /// Represents a data type consisting of a single signed character value.
    Char = 45,
    /// Represents a data type consisting of a vector of two signed character values.
    Char2 = 46,
    /// Represents a data type consisting of a vector of three signed character values.
    Char3 = 47,
    /// Represents a data type consisting of a vector of four signed character values.
    Char4 = 48,

    /// Represents a data type consisting of a single unsigned character value.
    UChar = 49,
    /// Represents a data type consisting of a vector of two unsigned character values.
    UChar2 = 50,
    /// Represents a data type consisting of a vector of three unsigned character values.
    UChar3 = 51,
    /// Represents a data type consisting of a vector of four unsigned character values.
    UChar4 = 52,

    /// Represents a data type consisting of a single boolean value.
    Bool = 53,
    /// Represents a data type consisting of a vector of two boolean values.
    Bool2 = 54,
    /// Represents a data type consisting of a vector of three boolean values.
    Bool3 = 55,
    /// Represents a data type consisting of a vector of four boolean values.
    Bool4 = 56,

    /// Represents a data type corresponding to a texture object.
    Texture = 58,
    /// Represents a data type corresponding to a sampler state object.
    Sampler = 59,
    /// Represents a data type corresponding to a pointer.
    Pointer = 60,

    /// Represents an image block data type consisting of an unsigned 8-bit red channel normalized to the [0-1] range.
    R8Unorm = 62,
    /// Represents an image block data type consisting of an signed 8-bit red channel normalized to the [0-1] range.
    R8Snorm = 63,
    /// Represents an image block data type consisting of an unsigned 16-bit red channel normalized to the [0-1] range.
    R16Unorm = 64,
    /// Represents an image block data type consisting of a signed 16-bit red channel normalized to the [0-1] range.
    R16Snorm = 65,
    /// Represents an image block data type consisting of an unsigned 8-bit red channel and a unsigned 8-bit green channel, both normalized to the [0-1] range.
    RG8Unorm = 66,
    /// Represents an image block data type consisting of a signed 8-bit red channel and a signed 8-bit green channel, both normalized to the [0-1] range.
    RG8Snorm = 67,
    /// Represents an image block data type consisting of an unsigned 16-bit red channel and an unsigned 16-bit green channel, both normalized to the [0-1] range.
    RG16Unorm = 68,
    /// Represents an image block data type consisting of a signed 16-bit red channel and a signed 16-bit green channel, both normalized to the [0-1] range.
    RG16Snorm = 69,
    /// Represents an image block data type consisting of four unsigned 8-bit channels normalized to the [0-1] range.
    RGBA8Unorm = 70,
    /// Represents an image block data type consisting of four unsigned 8-bit channels normalized to the [0-1] range and subject to gamma-correction.
    RGBA8Unorm_sRGB = 71,
    /// Represents an image block data type consisting of four signed 8-bit channels normalized to the [0-1] range.
    RGBA8Snorm = 72,
    /// Represents an image block data type consisting of four unsigned 16-bit channels normalized to the [0-1] range.
    RGBA16Unorm = 73,
    /// Represents an image block data type consisting of four signed 16-bit channels normalized to the [0-1] range.
    RGBA16Snorm = 74,
    /// Represents an image block data type consisting of three unsigned 10-bit channels and one 2-bit unsigned alpha channel, all normalized to the [0-1] range.
    RGB10A2Unorm = 75,
    /// Represents an image block data type consisting of two 11-bit floating-point channels, and one 10-bit floating-point blue channel.
    RG11B10Float = 76,
    /// Represents an image block data type consisting of three 9-bit floating-point channels, and one 5-bit floating-point exponent.
    RGB9E5Float = 77,
    /// Represents a data type corresponding to a render pipeline state object.
    RenderPipeline = 78,
    /// Represents a data type corresponding to a compute pipeline state object.
    ComputePipeline = 79,
    /// Represents a data type corresponding to an indirect command buffer object.
    IndirectCommandBuffer = 80,
    /// Represents a data type consisting of a signed long integer value.
    Long = 81,
    /// Represents a data type consisting of a vector of two signed long integer values.
    Long2 = 82,
    /// Represents a data type consisting of a vector of three signed long integer values.
    Long3 = 83,
    /// Represents a data type consisting of a vector of four signed long integer values.
    Long4 = 84,

    /// Represents a data type consisting of an unsigned long integer value.
    ULong = 85,
    /// Represents a data type consisting of a vector two unsigned long integer values.
    ULong2 = 86,
    /// Represents a data type consisting of a vector three unsigned long integer values.
    ULong3 = 87,
    /// Represents a data type consisting of a vector four unsigned long integer values.
    ULong4 = 88,
    /// Represents a data type corresponding to a visible function table object.
    VisibleFunctionTable = 115,
    /// Represents a data type corresponding to an intersection function table object.
    IntersectionFunctionTable = 116,
    /// Represents a data type corresponding to a primitive acceleration structure.
    PrimitiveAccelerationStructure = 117,
    /// Represents a data type corresponding to an instance acceleration structure.
    InstanceAccelerationStructure = 118,
    /// Represents a data type consisting of a single BFloat value.
    BFloat = 121,
    /// Represents a data type consisting of a vector two BFloat values.
    BFloat2 = 122,
    /// Represents a data type consisting of a vector three BFloat values.
    BFloat3 = 123,
    /// Represents a data type consisting of a vector four BFloat values.
    BFloat4 = 124,

    /// Represents a data type corresponding to a machine learning tensor.
    Tensor = 140,
}
