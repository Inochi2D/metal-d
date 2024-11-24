/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLCommandBuffer
*/
module metal.mtlcommandbuffer;
import foundation;
import metal;
import objc;

import core.attribute : selector;

/**
    A completion handler signature a GPU device calls when it 
    finishes scheduling a command buffer, or when the GPU finishes running it.
*/
alias MTLCommandBufferHandler = Block!(void, MTLCommandBuffer);

/**
    MTLCommandBufferStatus reports the current stage in the lifetime of MTLCommandBuffer, 
    as it proceeds to enqueued, committed, scheduled, and completed.
*/
enum MTLCommandBufferStatus : NSUInteger {
    
    /**
         The command buffer has not been enqueued yet.
    */
    NotEnqueued = 0,
    
    /**
        This command buffer is enqueued, but not committed.
    */
    Enqueued = 1,
    
    /**
        Commited to its command queue, but not yet scheduled for execution.
    */
    Committed = 2,
    
    /**
        All dependencies have been resolved and the command buffer has been scheduled for execution.
    */
    Scheduled = 3,
    
    /**
        The command buffer has finished executing successfully: 
        any blocks set with -addCompletedHandler: may now be called.
    */
    Completed = 4,
    
    /**
        Execution of the command buffer was aborted due to an error during execution.  
        Check -error for more information.
    */
    Error = 5,
}

/**
    Error codes that can be found in MTLCommandBuffer.error
*/
enum MTLCommandBufferError : NSUInteger {
    
    /**
        No error reported.
    */
    None = 0,
    
    /**
        An internal error that doesn't fit into the other categories.
        The actual low level error code is encoded in the local description.
    */
    Internal = 1,
    
    /**
        Execution of this command buffer took too long, execution of 
        this command was interrupted and aborted.
    */
    Timeout = 2,
    
    /**
        Execution of this command buffer generated an unserviceable GPU page fault. 
        
        This can caused by buffer read write attribute mismatch or out of boundary access.
    */
    PageFault = 3, 
    
    /**
        Access to this device has been revoked because this client has been 
        responsible for too many timeouts or hangs.
    */
    AccessRevoked = 4,
    
    /**
        This process does not have access to use this device.
    */
    NotPermitted = 7,
    
    /**
        Insufficient memory was available to execute this command buffer.
    */
    OutOfMemory = 8,
    
    /**
        The command buffer referenced an invalid resource.

        This is most commonly caused when the caller deletes a resource before 
        executing a command buffer that refers to it.
    */
    InvalidResource = 9,
    
    /**
        One or more internal resources limits reached that prevent using memoryless render pass attachments.
        See error string for more detail.
    */
    Memoryless = 10,
    
    /**
        The device was physically removed before the command could finish execution.
    */
    DeviceRemoved = 11,
    
    /**
        Execution of the command buffer was stopped due to Stack Overflow Exception.
        [MTLComputePipelineDescriptor.maxCallStackDepth] setting needs to be checked.
    */
    StackOverflow = 12,
}

/**
    A container that stores a sequence of GPU commands that you encode into it.
*/
extern(Objective-C)
extern interface MTLCommandBuffer : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The GPU device that indirectly owns the command buffer because 
        you created it from a command queue the device also owns.
    */
    @property MTLDevice device() const;

    /**
        The command queue that created the command buffer.
    */
    @property MTLCommandQueue device() const;

    /**
        An optional name that can help you identify the command buffer.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        The command buffer’s current state.
    */
    @property MTLCommandBufferStatus status() const;

    /**
        The host time, in seconds, when the CPU begins to schedule the command buffer.
    */
    @property CFTimeInterval kernelStartTime() const;

    /**
        The host time, in seconds, when the CPU finishes scheduling the command buffer.
    */
    @property CFTimeInterval kernelEndTime() const;

    /**
        The host time, in seconds, when the GPU starts command buffer execution.
    */
    @property CFTimeInterval gpuStartTime() const @selector("GPUStartTime");

    /**
        The host time, in seconds, when the GPU finishes execution of the command buffer.
    */
    @property CFTimeInterval gpuEndTime() const @selector("GPUEndTime");

    /**
        A Boolean value that indicates whether the command buffer 
        maintains strong references to the resources it uses.
    */
    @property bool retainedReferences() const;

    /**
        Creates a render command encoder from a descriptor.
    */
    MTLRenderCommandEncoder renderCommandEncoder(MTLRenderPassDescriptor descriptor) @selector("renderCommandEncoderWithDescriptor:");

    /**
        Registers a completion handler the GPU device calls immediately 
        after it schedules the command buffer to run on the GPU.
    */
    void addScheduledHandler(MTLCommandBufferHandler* block) @selector("addScheduledHandler:");

    /**
        Registers a completion handler the GPU device calls immediately 
        after the GPU finishes running the commands in the command buffer.
    */
    void addCompletedHandler(MTLCommandBufferHandler* block) @selector("addCompletedHandler:");

    /**
        Presents the drawable onscreen as soon as possible.
    */
    void present(MTLDrawable drawable) @selector("presentDrawable:");

    /**
        Presents the drawable onscreen as soon as possible after a previous 
        drawable is visible for the specified duration.
    */
    void present(MTLDrawable drawable, CFTimeInterval waitDuration) @selector("presentDrawable:afterMinimumDuration:");

    /**
        Presents the drawable onscreen at a specific host time.
    */
    void presentAt(MTLDrawable drawable, CFTimeInterval time) @selector("presentDrawable:atTime:");

    /**
        Reserves the next available place for the command buffer in 
        its command queue.
    */
    void enqueue() @selector("enqueue");

    /**
        Submits the command buffer to run on the GPU.
    */
    void commit() @selector("commit");

    /**
        Blocks the current thread until the command queue schedules the buffer.
    */
    void waitUntilScheduled() @selector("waitUntilScheduled");

    /**
        Blocks the current thread until the GPU finishes executing the 
        command buffer and all of its completion handlers.
    */
    void waitUntilCompleted() @selector("waitUntilCompleted");

    /**
        Marks the beginning of a debug group and gives it an identifying label, 
        which temporarily replaces the previous group, if applicable.
    */
    void pushDebugGroup(NSString label) @selector("pushDebugGroup:");

    /**
        Marks the end of a debug group and, if applicable, restores the previous group from a stack.
    */
    void popDebugGroup() @selector("popDebugGroup");
}

