/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLSamplerState
*/
module metal.stateobjects;
import metal.device;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;




//
//      SAMPLER STATE
//

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





//
//      DEPTH-STENCIL STATE
//

/**
    Options used to specify how a sample compare operation should be performed on a 
    depth texture.
*/
enum MTLCompareFunction : NSUInteger {
    
    /**
        A new value never passes the comparison test.
    */
    Never = 0,
    
    /**
        A new value passes the comparison test if it is less than the existing value.
    */
    Less = 1,
    
    /**
        A new value passes the comparison test if it is equal to the existing value.
    */
    Equal = 2,
    
    /**
        A new value passes the comparison test if it is less than or equal to the 
        existing value.
    */
    LessEqual = 3,
    
    /**
        A new value passes the comparison test if it is greater than the existing 
        value.
    */
    Greater = 4,
    
    /**
        A new value passes the comparison test if it is not equal to the existing 
        value.
    */
    NotEqual = 5,
    
    /**
        A new value passes the comparison test if it is greater than or equal to 
        the existing value.
    */
    GreaterEqual = 6,
    
    /**
        A new value always passes the comparison test.
    */
    Always = 7,
}

/**

*/
enum MTLStencilOperation : NSUInteger {
    
    /**
        Keep the current stencil value.
    */
    Keep = 0,
    
    /**
        Set the stencil value to zero.
    */
    Zero = 1,
    
    /**
        Replace the stencil value with the stencil reference value.
    */
    Replace = 2,
    
    /**
        If the current stencil value is not the maximum representable value, 
        increase the stencil value by one. 

        Otherwise, if the current stencil value is the maximum representable value, 
        do not change the stencil value.
    */
    IncrementClamp = 3,
    
    /**
        If the current stencil value is not zero, decrease the stencil value by one. 
        
        Otherwise, if the current stencil value is zero, do not change the stencil 
        value.
    */
    DecrementClamp = 4,
    
    /**
        Perform a logical bitwise invert operation on the current stencil value.
    */
    Invert = 5,
    
    /**
        If the current stencil value is not the maximum representable value, 
        increase the stencil value by one. 
        
        Otherwise, if the current stencil value is the maximum representable value, 
        set the stencil value to zero.
    */
    IncrementWrap = 6,
    
    /**
        If the current stencil value is not zero, decrease the stencil value by one. 
        
        Otherwise, if the current stencil value is zero, set the stencil value to the 
        maximum representable value.
    */
    DecrementWrap = 7,
}

/**
    An object that defines the front-facing or back-facing stencil operations of a 
    depth and stencil state object.
*/
extern(Objective-C)
extern class MTLStencilDescriptor : NSObject, NSCopying {
nothrow @nogc:
public:

    /**
        The comparison that is performed between the masked reference value and a 
        masked value in the stencil attachment.
    */
    @property MTLCompareFunction stencilCompareFunction();
    @property void stencilCompareFunction(MTLCompareFunction);

    /**
        The operation that is performed to update the values in the stencil attachment 
        when the stencil test fails.
    */
    @property MTLStencilOperation stencilFailureOperation();
    @property void stencilFailureOperation(MTLStencilOperation);

    /**
        The operation that is performed to update the values in the stencil attachment 
        when the stencil test passes, but the depth test fails.
    */
    @property MTLStencilOperation depthFailureOperation();
    @property void depthFailureOperation(MTLStencilOperation);

    /**
        The operation that is performed to update the values in the stencil attachment 
        when both the stencil test and the depth test pass.
    */
    @property MTLStencilOperation depthStencilPassOperation();
    @property void depthStencilPassOperation(MTLStencilOperation);

    /**
        A bitmask that determines from which bits that stencil comparison tests can 
        read.
    */
    @property uint readMask();
    @property void readMask(uint);

    /**
        A bitmask that determines to which bits that stencil operations can write.
    */
    @property uint writeMask();
    @property void writeMask(uint);

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    An object that configures new MTLDepthStencilState objects.
*/
extern(Objective-C)
extern class MTLDepthStencilDescriptor : NSObject, NSCopying {
nothrow @nogc:
public:

    /**
        A string that identifies this object.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        The comparison that is performed between a fragment’s depth value and the depth 
        value in the attachment, which determines whether to discard the fragment.
    */
    @property MTLCompareFunction depthCompareFunction();
    @property void depthCompareFunction(MTLCompareFunction);

    /**
        A Boolean value that indicates whether depth values can be written to the depth 
        attachment.
    */
    @property bool depthWriteEnabled() @selector("isDepthWriteEnabled");
    @property void depthWriteEnabled(bool);

    /**
        The stencil descriptor for front-facing primitives.
    */
    @property MTLStencilDescriptor frontFaceStencil();
    @property void frontFaceStencil(MTLStencilDescriptor);

    /**
        The stencil descriptor for back-facing primitives.
    */
    @property MTLStencilDescriptor backFaceStencil();
    @property void backFaceStencil(MTLStencilDescriptor);

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    A depth and stencil state object that specifies the depth and stencil 
    configuration and operations used in a render pass.
*/
extern(Objective-C)
extern interface MTLDepthStencilState : NSObjectProtocol {
nothrow @nogc:
public:

    /**
        A string that identifies this object.
    */
    @property NSString label() const;

    /**
        The device this resource was created against.
    */
    @property MTLDevice device() const;
}