/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Core Metal Types
*/
module metal.types;
import foundation;
import metal;
import objc;

/**
    The coordinates for the front upper-left corner of a region.
*/
struct MTLOrigin {
@nogc nothrow:
    NSUInteger x;
    NSUInteger y;
    NSUInteger z;
}

/**
    The dimensions of an object.
*/
struct MTLSize {
@nogc nothrow:
    NSUInteger width;
    NSUInteger height;
    NSUInteger depth;
}

/**
    The bounds for a subset of an object's elements.

    Metal has many object types that represent arrays of discrete elements. 
    For example, a texture has an array of pixel elements, and a thread grid has an array 
    of computational threads. Use MTLRegion instances to describe subsets of these objects.

    The origin is the front upper-left corner of the region, and its extents go towards the 
    back lower-right corner. Conceptually, when using a MTLRegion instance to describe a 
    subset of an object, treat the object as a 3D array of elements, even if it has fewer 
    dimensions. 
    
    For a 2D object, set the z coordinate of the origin to 0 and the depth to 1. 
    For a 1D object, set the y and z coordinates of the origin to 0 and the height and 
    depth to 1.
*/
struct MTLRegion {
@nogc nothrow:
    MTLOrigin origin;
    MTLSize size;
}

/**
    A subpixel sample position for use in multisample antialiasing (MSAA).

    Subpixel sample positions are in a 16 x 16 grid across a pixel. 
    Each subsample position’s x and y values are in 1/16 increments in the floating-point range [0.0, 15.0/16.0). 
    The pixel’s origin point (0,0) is at the top-left corner.

    See [Positioning Samples Programmatically](https://developer.com/documentation/metal/render_passes/positioning_samples_programmatically) for the details on working with subpixels.
*/
struct MTLSamplePosition {
    float x;
    float y;
}

/**
    The size and alignment of a resource, in bytes.
*/
struct MTLSizeAndAlign {
    NSUInteger size;
    NSUInteger align_;
}

/**
    A Metal Resource ID
*/
struct MTLResourceID {
    ulong _impl;
}

/**
    The data formats that describe the organization and characteristics of individual pixels in a texture.

    # Overview
    There are three varieties of pixel formats: ordinary, packed, and compressed. 
    For ordinary and packed formats, the name of the pixel format specifies the order of components 
    (such as R, RG, RGB, RGBA, BGRA), bits per component (such as 8, 16, 32), 
    and data type for the component (such as Float, Sint, Snorm, Uint, Unorm). 
    
    If the pixel format name has the _sRGB suffix, then reading and writing pixel data applies 
    sRGB gamma compression and decompression.
    The alpha component of sRGB pixel formats is always treated as a linear value. 
    For compressed formats, the name of the pixel format specifies a compression family 
    (such as ASTC, BC, EAC, ETC2, PVRTC).

    ### Note
    > Pixel format availability and capabilities vary by feature set. 
    > See [Pixel Format Capabilities](https://developer.com/metal/Metal-Feature-Set-Tables.pdf) for 
    > more information.

    # Storage Characteristics
    The number and size of each pixel component determines the storage size of each pixel format. 
    For example, the storage size of MTLPixelFormatBGRA8Unorm is 32 bits (four 8-bit components) and 
    the storage size of MTLPixelFormatBGR5A1Unorm is 16 bits (three 5-bit components and one 1-bit component).

    For normalized signed integer formats (Snorm), values in the range [-1.0, 1.0] map to [MIN_INT, MAX_INT], 
    where MIN_INT is the greatest negative integer and MAX_INT is the greatest positive integer for the number 
    of bits in the storage size. Positive values and zero distribute uniformly in the range [0,1.0], and 
    negative integer values greater than (MIN_INT + 1) distribute uniformly in the range (-1.0, 0).

    ### Important
    > For Snorm formats, the values MIN_INT and (MIN_INT + 1) both map to -1.0.

    For normalized unsigned integer formats (Unorm), values in the range [0.0, 1.0] are uniformly 
    mapped to [0, MAX_UINT], where MAX_UINT is the greatest unsigned integer for the number of bits 
    in the storage size.

    Format data is little-endian (the least-significant byte in the least-significant address). 
    For formats with components that are themselves byte-aligned and more than one byte, the 
    components are also little-endian.

    See Table 7.7 in the [Metal Shading Language Specification](https://developer.com/metal/Metal-Shading-Language-Specification.pdf) (PDF) 
    for details on pixel format normalization.
*/
enum MTLPixelFormat : NSUInteger {
    Invalid = 0,
    A8Unorm = 1,
    R8Unorm = 10,
    R8Unorm_sRGB = 11,
    R8Snorm = 12,
    R8Uint = 13,
    R8Sint = 14,
    R16Unorm = 20,
    R16Snorm = 22,
    R16Uint = 23,
    R16Sint = 24,
    R16Float = 25,
    RG8Unorm = 30,
    RG8Unorm_sRGB = 31,
    RG8Snorm = 32,
    RG8Uint = 33,
    RG8Sint = 34,
    B5G6R5Unorm = 40,
    A1BGR5Unorm = 41,
    ABGR4Unorm = 42,
    BGR5A1Unorm = 43,
    R32Uint = 53,
    R32Sint = 54,
    R32Float = 55,
    RG16Unorm = 60,
    RG16Snorm = 62,
    RG16Uint = 63,
    RG16Sint = 64,
    RG16Float = 65,
    RGBA8Unorm = 70,
    RGBA8Unorm_sRGB = 71,
    RGBA8Snorm = 72,
    RGBA8Uint = 73,
    RGBA8Sint = 74,
    BGRA8Unorm = 80,
    BGRA8Unorm_sRGB = 81,
    RGB10A2Unorm = 90,
    RGB10A2Uint = 91,
    RG11B10Float = 92,
    RGB9E5Float = 93,
    BGR10A2Unorm = 94,
    BGR10_XR = 554,
    BGR10_XR_sRGB = 555,
    RG32Uint = 103,
    RG32Sint = 104,
    RG32Float = 105,
    RGBA16Unorm = 110,
    RGBA16Snorm = 112,
    RGBA16Uint = 113,
    RGBA16Sint = 114,
    RGBA16Float = 115,
    BGRA10_XR = 552,
    BGRA10_XR_sRGB = 553,
    RGBA32Uint = 123,
    RGBA32Sint = 124,
    RGBA32Float = 125,
    BC1_RGBA = 130,
    BC1_RGBA_sRGB = 131,
    BC2_RGBA = 132,
    BC2_RGBA_sRGB = 133,
    BC3_RGBA = 134,
    BC3_RGBA_sRGB = 135,
    BC4_RUnorm = 140,
    BC4_RSnorm = 141,
    BC5_RGUnorm = 142,
    BC5_RGSnorm = 143,
    BC6H_RGBFloat = 150,
    BC6H_RGBUfloat = 151,
    BC7_RGBAUnorm = 152,
    BC7_RGBAUnorm_sRGB = 153,
    PVRTC_RGB_2BPP = 160,
    PVRTC_RGB_2BPP_sRGB = 161,
    PVRTC_RGB_4BPP = 162,
    PVRTC_RGB_4BPP_sRGB = 163,
    PVRTC_RGBA_2BPP = 164,
    PVRTC_RGBA_2BPP_sRGB = 165,
    PVRTC_RGBA_4BPP = 166,
    PVRTC_RGBA_4BPP_sRGB = 167,
    EAC_R11Unorm = 170,
    EAC_R11Snorm = 172,
    EAC_RG11Unorm = 174,
    EAC_RG11Snorm = 176,
    EAC_RGBA8 = 178,
    EAC_RGBA8_sRGB = 179,
    ETC2_RGB8 = 180,
    ETC2_RGB8_sRGB = 181,
    ETC2_RGB8A1 = 182,
    ETC2_RGB8A1_sRGB = 183,
    ASTC_4x4_sRGB = 186,
    ASTC_5x4_sRGB = 187,
    ASTC_5x5_sRGB = 188,
    ASTC_6x5_sRGB = 189,
    ASTC_6x6_sRGB = 190,
    ASTC_8x5_sRGB = 192,
    ASTC_8x6_sRGB = 193,
    ASTC_8x8_sRGB = 194,
    ASTC_10x5_sRGB = 195,
    ASTC_10x6_sRGB = 196,
    ASTC_10x8_sRGB = 197,
    ASTC_10x10_sRGB = 198,
    ASTC_12x10_sRGB = 199,
    ASTC_12x12_sRGB = 200,
    ASTC_4x4_LDR = 204,
    ASTC_5x4_LDR = 205,
    ASTC_5x5_LDR = 206,
    ASTC_6x5_LDR = 207,
    ASTC_6x6_LDR = 208,
    ASTC_8x5_LDR = 210,
    ASTC_8x6_LDR = 211,
    ASTC_8x8_LDR = 212,
    ASTC_10x5_LDR = 213,
    ASTC_10x6_LDR = 214,
    ASTC_10x8_LDR = 215,
    ASTC_10x10_LDR = 216,
    ASTC_12x10_LDR = 217,
    ASTC_12x12_LDR = 218,
    ASTC_4x4_HDR = 222,
    ASTC_5x4_HDR = 223,
    ASTC_5x5_HDR = 224,
    ASTC_6x5_HDR = 225,
    ASTC_6x6_HDR = 226,
    ASTC_8x5_HDR = 228,
    ASTC_8x6_HDR = 229,
    ASTC_8x8_HDR = 230,
    ASTC_10x5_HDR = 231,
    ASTC_10x6_HDR = 232,
    ASTC_10x8_HDR = 233,
    ASTC_10x10_HDR = 234,
    ASTC_12x10_HDR = 235,
    ASTC_12x12_HDR = 236,
    GBGR422 = 240,
    BGRG422 = 241,
    Depth16Unorm = 250,
    Depth32Float = 252,
    Stencil8 = 253,
    Depth24Unorm_Stencil8 = 255,
    Depth32Float_Stencil8 = 260,
    X32_Stencil8 = 261,
    X24_Stencil8 = 262,
}