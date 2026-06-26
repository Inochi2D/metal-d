/**
    MTLRenderPipeline

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Asadbek Sindarov 
*/
module metal.computepipeline;
import metal.library;
import metal.renderpass;
import metal.types;
import metal.device;
import metal.argument;
import foundation;
import metal.buffer;
import metal.commandencoder;
import objc;
import core.attribute : selector, optional;

extern (Objective-C)
extern interface MTLComputeCommandEncoder : MTLCommandEncoder {

    /** 
        Configures the compute encoder with a pipeline state for subsequent kernel calls. 
    
        Params:
            state = An $(D MTLComputePipelineState) instance
    */
    void setComputePipelineState(MTLComputePipelineState state) @selector("setComputePipelineState:");

    /**
        Binds a buffer to the buffer argument table, allowing compute kernels to access its data on the GPU.

        Params:
            buffer = The $(D MTLBuffer) instance to bind to the argument table.
            offset = The number of bytes to skip in the buffer before the first element of data.
            index = The index the buffer binds to in the argument table.
    */
    void setBuffer(MTLBuffer buffer, NSUInteger offset, NSUInteger index) @selector("setBuffer:offset:atIndex:");

    /**
        Copies data directly to the GPU to populate an entry in the buffer argument table.

        Params:
            bytes = A pointer to where the data to copy starts. 
            length = The number of bytes to copy.
            index = The index the buffer binds to in the argument table.
     */
    void setBytes(void* bytes, NSUInteger length, NSUInteger index) @selector("setBytes:length:atIndex:");

    /**
        Encodes a compute command using an arbitrarily sized grid.

        Params:
            threadsPerGrid = The number of threads in the grid, in each dimension.
            threadsPerThreadgroup = The number of threads in one threadgroup, in each dimension.
    */
    void dispatchThreads(MTLSize threadsPerGrid, MTLSize threadsPerThreadgroup) @selector("dispatchThreads:threadsPerThreadgroup:");

    /**
        Encodes a compute dispatch command using a grid aligned to threadgroup boundaries.
    
        Params:
            threadgroupsPerGrid = An $(D MTLSize) instance that represents the number of threads for each grid dimension.
            threadsPerThreadgroup = An $(D MTLSize) instance that represents the number of threads in a threadgroup.
    */
    void dispatchThreadgroups(MTLSize threadgroupsPerGrid, MTLSize threadsPerThreadgroup) @selector("dispatchThreadgroups:threadsPerThreadgroup:");

    /**
        Declares that all command generation from the encoder is completed.
    */
    void endEncoding() @selector("endEncoding");
}

/**
    Information about the arguments of a compute function.
*/
extern (Objective-C)
extern interface MTLComputePipelineReflection : NSObjectProtocol {
@nogc nothrow
public:

    /** 
        An array of $(D MTLBinding) objects that describe the arguments of the compute function.
    */
    @property NSArray!MTLBinding bindings() @selector("bindings");
}

/**
    A convenience type alias for an autoreleased compute pipeline reflection object.
*/
alias MTLAutoreleasedComputePipelineReflection = MTLComputePipelineReflection;

/**
    An interface that represents a GPU pipeline configuration for running kernels in a compute pass.
*/
extern (Objective-C)
extern interface MTLComputePipelineState : NSObjectProtocol {
@nogc nothrow
public:

    /**
        The device instance that created the pipeline state.
    */
    @property MTLDevice device() const;

    /**
        A string that helps identify the compute pipeline state during debugging.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        An unique identifier that represents the pipeline state, 
        which you can add to an argument buffer.
    */
    @property MTLResourceID gpuResourceID() const;

    /**
        The maximum number of threads in a threadgroup that can be dispatch to the pipeline.
    */
    @property NSUInteger maxTotalThreadsPerThreadgroup() const;

    /**
        The number of threads that the GPU executes simultaneously.
    */
    @property NSUInteger threadExecutionWidth() const;

    /**
        The length, in bytes, of statically allocated threadgroup memory.
    */
    @property NSUInteger staticThreadgroupMemoryLength() const;

    /**
        Returns the length of reserved memory for an imageblock of a given size.
    */
    @property NSUInteger imageblockMemoryLengthForDimensions(MTLSize imageblockDimensions) @selector(
        "imageblockMemoryLengthForDimensions:") ;

    /**
        A Boolean value that indicates whether the compute pipeline supports indirect command buffers.
    */
   @property bool supportIndirectCommandBuffers() const; 

    /**
        The current state of shader validation for the pipeline.
    */
    @property MTLShaderValidation shaderValidation() const;
}
