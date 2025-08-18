/**
    MTLFunctionHandle

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.functionhandle;
import metal.types;
import metal.resource;
import metal.library;
import metal.device;
import foundation;
import objc;

/**
    An object representing a function that you can add to a visible function table.
*/
extern(Objective-C)
extern interface MTLFunctionHandle : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The device object that created the shader function.
    */
    @property MTLDevice device();

    /**
        The function’s name.
    */
    @property NSString name();

    /**
        The shader function’s type.
    */
    @property MTLFunctionType functionType();

    /**
        Handle of the GPU resource suitable for storing in an Intersection Function Buffer.
    */
    version(Metal4)
    @property MTLResourceID gpuResourceID();
}