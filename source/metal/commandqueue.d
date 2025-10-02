/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLCommandQueue
*/
module metal.commandqueue;
import metal.device;
import metal.commandbuffer;
import metal;
import foundation;
import objc;

import core.attribute : selector;


/**
    A configuration that customizes the behavior for a new command queue.
*/
extern(Objective-C)
extern class MTLCommandQueueDescriptor : NSObject {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLCommandQueueDescriptor alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLCommandQueueDescriptor init() @selector("init");

    /**
        An integer that sets the maximum number of uncompleted command buffers the queue can allow.
    */
    @property NSUInteger maxCommandBufferCount();
    @property void maxCommandBufferCount(NSUInteger);

}

/**
    An instance you use to create, submit, and schedule command buffers to a specific GPU 
    device to run the commands within those buffers.

    # Overview

    A command queue maintains an ordered list of command buffers. You use a command queue to:

        * Create command buffers, which you fill with commands for the GPU device that creates the queue

        * Submit command buffers to run on that GPU

    Create a command queue from an MTLDevice instance by calling its `newCommandQueue` method.  
    Typically, you create one or more command queues when your app launches and then keep them throughout your app’s lifetime.

    With each MTLCommandQueue instance you create, you can create MTLCommandBuffer instances for that queue by calling its 
    commandBuffer or commandBufferWithUnretainedReferences method.

    ### Note
    > Each command queue is thread-safe and allows you to encode commands in multiple command buffers simultaneously.

    For more information about command buffers and encoding GPU commands to them — 
    such as rendering images and computing data in parallel — 
    see [Setting Up a Command Structure](https://developer.com/documentation/metal/gpu_devices_and_work_submission/setting_up_a_command_structure).
*/
extern(Objective-C)
extern interface MTLCommandQueue : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The GPU device that created the command queue.
    */
    @property MTLDevice device();

    /**
        An optional name that can help you identify the command queue.
    */
    @property NSString label();
    @property void label(NSString value);

    /**
        Returns a command buffer from the command queue that maintains strong references to resources.
    */
    MTLCommandBuffer commandBuffer() @selector("commandBuffer");

    /**
        Returns a command buffer from the command queue that doesn’t maintain strong references to resources.
    */
    MTLCommandBuffer commandBufferWithUnretainedReferences() @selector("commandBufferWithUnretainedReferences");
}

