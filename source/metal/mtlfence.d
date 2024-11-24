/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLTexture
*/
module metal.mtlfence;
import metal.mtldevice;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    A memory fence to capture, track, and manage resource dependencies across command encoders.
*/
extern(Objective-C)
extern interface MTLFence : NSObjectProtocol {
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
}