/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLArgument
*/
module metal.mtldepthstencil;
import metal.mtldevice;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;

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