/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLParallelRenderCommandEncoder
*/
module metal.mtlparallelrendercommandencoder;
import metal.mtlcommandencoder;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    An interface that encodes a render pass into a command buffer, 
    including all its draw calls and configuration.
*/
extern(Objective-C)
extern interface MTLParallelRenderCommandEncoder : MTLCommandEncoder {
@nogc nothrow:
public:

    
}