/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLRenderPipeline
*/
module metal.mtlrenderpipeline;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    Indicates whether shader validation in an enabled or disabled state, 
    or neither state.
*/
enum MTLShaderValidation : NSInteger {
    Default,
    Disabled,
    Enabled
}

/**

*/
enum MTLBlendFactor : NSUInteger {
    Zero = 0,
    One = 1,
    SourceColor = 2,
    OneMinusSourceColor = 3,
    SourceAlpha = 4,
    OneMinusSourceAlpha = 5,
    DestinationColor = 6,
    OneMinusDestinationColor = 7,
    DestinationAlpha = 8,
    OneMinusDestinationAlpha = 9,
    SourceAlphaSaturated = 10,
    BlendColor = 11,
    OneMinusBlendColor = 12,
    BlendAlpha = 13,
    OneMinusBlendAlpha = 14,
    Source1Color = 15,
    OneMinusSource1Color = 16,
    Source1Alpha = 17,
    OneMinusSource1Alpha = 18,
}

/**

*/
enum MTLBlendOperation : NSUInteger {
    Add = 0,
    Subtract = 1,
    ReverseSubtract = 2,
    Min = 3,
    Max = 4,
}

/**

*/
enum MTLColorWriteMask : NSUInteger {
    None  = 0,
    Red   = 0x1 << 3,
    Green = 0x1 << 2,
    Blue  = 0x1 << 1,
    Alpha = 0x1 << 0,
    All   = 0xf
}

/**

*/
enum MTLPrimitiveTopologyClass : NSUInteger {
    Unspecified = 0,
    Point = 1,
    Line = 2,
    Triangle = 3,
}

/**

*/
enum MTLTessellationPartitionMode : NSUInteger {
    Pow2 = 0,
    Integer = 1,
    FractionalOdd = 2,
    FractionalEven = 3,
}

/**

*/
enum MTLTessellationFactorStepFunction : NSUInteger {
    Constant = 0,
    PerPatch = 1,
    PerInstance = 2,
    PerPatchAndPerInstance = 3,
}

/**

*/
enum MTLTessellationFactorFormat : NSUInteger {
    Half = 0,
}

/**

*/
enum MTLTessellationControlPointIndexType : NSUInteger {
    None = 0,
    UInt16 = 1,
    UInt32 = 2,
}

/**
    An interface that represents a graphics pipeline configuration for a render pass, 
    which the pass applies to the draw commands you encode.
*/
extern(Objective-C)
extern interface MTLRenderPipelineState : NSObjectProtocol {
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
        An unique identifier that represents the pipeline state, 
        which you can add to an argument buffer.
    */
    @property MTLResourceID gpuResourceID() const;

    /**
        The largest number of threads the pipeline state can have 
        in a single object shader threadgroup.
    */
    @property NSUInteger maxTotalThreadsPerObjectThreadgroup() const;

    /**
        The number of threads the render pass applies to a SIMD group 
        for an object shader.
    */
    @property NSUInteger objectThreadExecutionWidth() const;

    /**
        The largest number of threads the pipeline state can have 
        in a single mesh shader threadgroup.
    */
    @property NSUInteger maxTotalThreadsPerMeshThreadgroup() const;

    /**
        The largest number of threadgroups the pipeline state can 
        have in a single mesh shader grid.
    */
    @property NSUInteger maxTotalThreadgroupsPerMeshGrid() const;

    /**
        The number of threads the render pass applies to a SIMD group 
        for a mesh shader.
    */
    @property NSUInteger meshThreadExecutionWidth() const;

    /**
        The largest number of threads the pipeline state can have 
        in a single tile shader threadgroup.
    */
    @property NSUInteger maxTotalThreadsPerThreadgroup() const;

    /**
        A Boolean value that indicates whether the pipeline state 
        needs a threadgroup’s size to equal a tile’s size.
    */
    @property NSUInteger threadgroupSizeMatchesTileSize() const;

    /**
        The memory size, in byes, of the render pipeline’s imageblock 
        for a single sample.
    */
    @property NSUInteger imageblockSampleLength() const;

    /**
        A Boolean value that indicates whether the render pipeline 
        supports encoding commands into an indirect command buffer.
    */
    @property bool supportIndirectCommandBuffers() const;

    /**
        The current state of shader validation for the pipeline.
    */
    @property MTLShaderValidation shaderValidation() const;
    
    /**
        Returns the length of an imageblock’s memory for the specified
        imageblock dimensions.
    */
    @property NSUInteger imageblockMemoryLengthForDimensions(MTLSize imageblockDimensions) @selector("imageblockMemoryLengthForDimensions:");
}