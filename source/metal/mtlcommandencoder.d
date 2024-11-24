/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLCommandBuffer
*/
module metal.mtlcommandencoder;
import metal.mtldevice;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    An encoder that writes GPU commands into a command buffer.
*/
extern(Objective-C)
extern interface MTLCommandEncoder : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The GPU device that created the command queue.
    */
    @property MTLDevice device() const;

    /**
        An optional name that can help you identify the command queue.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        Declares that all command generation from the encoder is completed.
    */
    void endEncoding() @selector("endEncoding");

    /**
        Inserts a debug string into the captured frame data.
    */
    void insertDebugSignpost(NSString label) @selector("insertDebugSignpost:");

    /**
        Pushes a specific string onto a stack of debug group strings for the command encoder.
    */
    void pushDebugGroup(NSString label) @selector("pushDebugGroup:");

    /**
        Pops the latest string off of a stack of debug group strings for the command encoder.
    */
    void popDebugGroup() @selector("popDebugGroup");
}