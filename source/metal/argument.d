/**
    MTLArgument

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.argument;
import metal.texture;
import metal.commandencoder;
import foundation;
import objc;

enum MTLIndexType : NSUInteger {
    UInt16 = 0,
    UInt32 = 1,
}

/**
    The type of a resource binding.
*/
enum MTLBindingType : NSUInteger {

    /**
        This binding represents a buffer.
    */
    Buffer = 0,

    /**
        This binding represents threadgroup memory.
    */
    ThreadgroupMemory = 1,

    /**
        This binding represents a texture.
    */
    Texture = 2,

    /**
        This binding represents a sampler.
    */
    Sampler = 3,

    /**
        This binding represents an image block data.
    */
    ImageblockData = 16,

    /**
        This binding represents an image block.
    */
    Imageblock = 17,

    /**
        This binding represents a visible function table object.
    */
    VisibleFunctionTable = 24,

    /**
        This binding represents a primitive acceleration structure object.
    */
    PrimitiveAccelerationStructure = 25,

    /**
        This binding represents an instance acceleration structure object.
    */
    InstanceAccelerationStructure = 26,

    /**
        This binding represents an intersection function table object.
    */
    IntersectionFunctionTable = 27,

    /**
        This binding represents an object payload.
    */
    ObjectPayload = 34,

    /**
        This binding represents a tensor object.
    */
    Tensor = 37,
}

/**
    The type for an input to a MTLRenderPipelineState or a MTLComputePipelineState
*/
enum MTLArgumentType : NSUInteger {

    /**
        This input is a MTLBuffer
    */
    Buffer = 0,

    /**
        This input is a pointer to the threadgroup memory.
    */
    ThreadgroupMemory = 1,

    /**
        This input is a MTLTexture.
    */
    Texture = 2,

    /**
        This input is a sampler.
    */
    Sampler = 3,

    MTLArgumentTypeImageblockData = 16,
    MTLArgumentTypeImageblock = 17,
    MTLArgumentTypeVisibleFunctionTable = 24,
    MTLArgumentTypePrimitiveAccelerationStructure = 25,
    MTLArgumentTypeInstanceAccelerationStructure = 26,
    MTLArgumentTypeIntersectionFunctionTable = 27,
}

enum MTLBindingAccess : NSUInteger {
    ReadOnly   = 0,
    ReadWrite  = 1,
    WriteOnly  = 2,
}
