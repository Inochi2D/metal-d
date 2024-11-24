/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLSamplerState
*/
module metal.mtlsamplerstate;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    Options for filtering texels within a mip level.   
*/
enum MTLSamplerMinMagFilter : NSUInteger
{

    /**
        Select the single texel nearest to the sample point.
    */
    Nearest = 0,

    /**
        Select two texels in each dimension, and interpolate linearly between them.
        Not all devices support linear filtering for all formats.
        Integer textures can not use linear filtering on any device, 
        and only some devices support linear filtering of float textures.
    */
    Linear = 1,
}

/**
    Options for selecting and filtering between mipmap levels
*/
enum MTLSamplerMipFilter : NSUInteger
{

    /**
        The texture is sampled as if it only had a single mipmap level.  All samples are read from level 0.
    */
    NotMipmapped = 0,

    /**
        The nearst mipmap level is selected.
    */
    Nearest = 1,

    /**
        If the filter falls between levels, both levels are sampled, 
        and their results linearly interpolated between levels.
    */
    Linear = 2,
}

/**
    Options for what value is returned when a fetch falls outside the bounds of a texture.
*/
enum MTLSamplerAddressMode : NSUInteger
{

    /**
        Texture coordinates will be clamped between 0 and 1.
    */
    ClampToEdge = 0,

    /**
        Mirror the texture while coordinates are within -1..1, and clamp to edge when outside.
    */
    MirrorClampToEdge = 1,

    /**
        Wrap to the other side of the texture, effectively ignoring fractional parts of the 
        texture coordinate.
    */
    Repeat = 2,

    /**
        Between -1 and 1 the texture is mirrored across the 0 axis.
        
        The image is repeated outside of that range.
    */
    MirrorRepeat = 3,

    /**
        ClampToZero returns transparent zero (0,0,0,0) for images with an alpha channel, 
        and returns opaque zero (0,0,0,1) for images without an alpha channel.
    */
    ClampToZero = 4,

    /**
        ClampToBorderColor returns the value specified by the borderColor variable of 
        the MTLSamplerDesc.
    */
    ClampToBorderColor = 5,
}

/**
    Specify the color value that will be clamped to when the sampler address mode is 
    ClampToBorderColor.
*/
enum MTLSamplerBorderColor : NSUInteger
{

    /**
        TransparentBlack returns {0,0,0,0} for clamped texture values.
    */
    TransparentBlack = 0,

    /**
        OpaqueBlack returns {0,0,0,1} for clamped texture values.
    */
    OpaqueBlack = 1,

    /**
        OpaqueWhite returns {1,1,1,1} for clamped texture values.
    */
    OpaqueWhite = 2,
}

/**
    An object that you use to configure a texture sampler.
*/
extern (Objective-C)
extern class MTLSamplerDescriptor : NSObject, NSCopying
{
nothrow @nogc:
public:

    /**
        A string that identifies this object.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        A Boolean value that indicates whether texture coordinates are 
        normalized to the range [0.0, 1.0].
    */
    @property bool normalizedCoordinates();
    @property void normalizedCoordinates(bool);

    /**
        The address mode for the texture depth (r) coordinate.
    */
    @property MTLSamplerAddressMode rAddressMode();
    @property void rAddressMode(MTLSamplerAddressMode);

    /**
        The address mode for the texture width (s) coordinate.

        Also known as the "u" coordinate.
    */
    @property MTLSamplerAddressMode sAddressMode();
    @property void sAddressMode(MTLSamplerAddressMode);

    /**
        The address mode for the texture height (t) coordinate.

        Also known as the "v" coordinate.
    */
    @property MTLSamplerAddressMode tAddressMode();
    @property void tAddressMode(MTLSamplerAddressMode);

    /**
        The border color for clamped texture values.
    */
    @property MTLSamplerBorderColor borderColor();
    @property void borderColor(bool);

    /**
        The filtering option for combining pixels within one mipmap level when 
        the sample footprint is larger than a pixel (minification).
    */
    @property MTLSamplerMinMagFilter minFilter();
    @property void minFilter(MTLSamplerMinMagFilter);

    /**
        The filtering operation for combining pixels within one mipmap level when 
        the sample footprint is smaller than a pixel (magnification).
    */
    @property MTLSamplerMinMagFilter magFilter();
    @property void magFilter(MTLSamplerMinMagFilter);

    /**
        The filtering option for combining pixels between two mipmap levels.
    */
    @property MTLSamplerMipFilter mipFilter();
    @property void mipFilter(MTLSamplerMipFilter);

    /**
        The minimum level of detail (LOD) to use when sampling from a texture.
    */
    @property float lodMinClamp();
    @property void lodMinClamp(float);

    /**
        The maximum level of detail (LOD) to use when sampling from a texture.
    */
    @property float lodMaxClamp();
    @property void lodMaxClamp(float);

    /**
        A Boolean value that specifies whether the GPU can use an average 
        level of detail (LOD) when sampling from a texture.
    */
    @property bool lodAverage();
    @property void lodAverage(bool);

    /**
        The number of samples that can be taken to improve the quality of 
        sample footprints that are anisotropic.
    */
    @property NSUInteger maxAnisotropy();
    @property void maxAnisotropy(NSUInteger);

    /**
        The sampler comparison function used when performing a sample 
        compare operation on a depth texture.
    */
    @property MTLCompareFunction compareFunction();
    @property void compareFunction(MTLCompareFunction);

    /**
        A Boolean value that specifies whether the sampler can be encoded 
        into an argument buffer.
    */
    @property bool supportArgumentBuffers();
    @property void supportArgumentBuffers(bool);

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:") ;
}

/**
    An object that defines how a texture should be sampled.
*/
extern (Objective-C)
extern interface MTLSamplerState : NSObjectProtocol
{
nothrow @nogc:
public:

    /**
        A string that identifies the sampler.
    */
    @property NSString label() const;

    /**
        The device object that created the sampler.
    */
    @property MTLDevice device() const;

    /**
        The GPU resource ID.
    */
    @property MTLResourceID gpuResourceID() const;
}
