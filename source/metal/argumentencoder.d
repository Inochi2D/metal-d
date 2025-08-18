/**
    MTLArgumentEncoder

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.argumentencoder;
import metal.device;
import metal.buffer;
import metal.texture;
import metal.sampler;
import metal.renderpass;
import foundation;
import objc;

/**
    When calling functions with an `attributeStrides:` parameter on a render
    or compute command encoder, this value must be provided for the binding
    points that are either not part of the set of MTLBufferLayoutDescriptor,
    or whose stride values in the descriptor is not set to
    `MTLBufferLayoutStrideDynamic`
*/
extern(C) extern __gshared const NSUInteger MTLAttributeStrideStatic;

/**
    Encodes buffer, texture, sampler, and constant data into a buffer.
*/
extern(Objective-C)
extern interface MTLArgumentEncoder : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The device this argument encoder was created against.
    */
    @property MTLDevice device();

    /**
        A string to help identify this object.
    */
    @property NSString label();
    @property void label(NSString value);

    /**
        The number of bytes required to store the encoded resource bindings.
    */
    @property NSUInteger encodedLength();

    /**
        The alignment in bytes required to store the encoded resource bindings.
    */
    @property NSUInteger alignment();
}