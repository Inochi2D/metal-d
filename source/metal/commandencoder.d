/**
    MTLCommandEncoder

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.commandencoder;
import objc.basetypes;
import foundation;
import metal.device;

import core.attribute : selector, optional;

enum MTLResourceUsage : NSUInteger {
    Read   = 1 << 0,
    Write  = 1 << 1,

    deprecated("Use MTLResourceUsage.Read")
    Sample = 1 << 2
}

enum MTLBarrierScope : NSUInteger {
    Buffers = 1 << 0,
    Textures = 1 << 1,
    RenderTargets = 1 << 2,
}

enum MTLStages : NSUInteger {

    /// Represents all vertex shader stage work in a render pass.
    Vertex                = 1 << 0,
    
    /// Represents all fragment shader stage work in a render pass.
    Fragment              = 1 << 1,
    
    /// Represents all tile shading stage work in a render pass.
    Tile                  = 1 << 2,
    
    /// Represents all object shader stage work in a render pass.
    bject                = 1 << 3,
    
    /// Represents all mesh shader stage work work in a render pass.
    Mesh                  = 1 << 4,
    
    /// Represents all sparse and placement sparse resource mapping updates.
    ResourceState         = 1 << 26,
    
    /// Represents all compute dispatches in a compute pass.
    Dispatch              = 1 << 27,
    
    /// Represents all blit operations in a pass.
    Blit                  = 1 << 28,
    
    /// Represents all acceleration structure operations.
    AccelerationStructure = 1 << 29,
    
    /// Represents all machine learning network dispatch operations.
    MachineLearning       = 1 << 30,

    /// Convenience mask representing all stages of GPU work.
    All                   = NSInteger.max
}

/**
    The common interface for objects that write commands into 
    MTLCommandBuffers.
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