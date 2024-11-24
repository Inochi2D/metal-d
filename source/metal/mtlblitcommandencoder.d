/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLBlitCommandEncoder
*/
module metal.mtlblitcommandencoder;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    The options that enable behavior for some blit operations.
*/
enum MTLBlitOptions : NSUInteger {
    
    /**
        A blit option that clears other blit options, which removes any optional 
        behavior for a blit operation.
    */
    None                       = 0,
    
    /**
        A blit option that copies the depth portion of a combined depth and stencil 
        texture to or from a buffer.
    */
    DepthFromDepthStencil      = 1 << 0,
    
    /**
        A blit option that copies the stencil portion of a combined depth and stencil 
        texture to or from a buffer.
    */
    StencilFromDepthStencil    = 1 << 1,
    
    /**
        A blit option that copies PVRTC data between a texture and a buffer.
    */
    RowLinearPVRTC = 1 << 2,
}

/**
    An interface that encodes a render pass into a command buffer, including all its draw 
    calls and configuration.
*/
extern(Objective-C)
extern interface MTLBlitCommandEncoder : MTLCommandEncoder {
@nogc nothrow:
public:

    /**
        Encodes a command that fills a buffer with a constant value for each byte.
    */
    void fillBuffer(MTLBuffer buffer, NSRange range, ubyte value) @selector("fillBuffer:range:value:");

    /**
        Encodes a command that generates mipmaps for a texture from the base mipmap 
        level up to the highest mipmap level.
    */
    void generateMipmapsForTexture(MTLTexture texture) @selector("generateMipmapsForTexture:");

    /**
        Encodes a command that copies data from one buffer into another.
    */
    void copy(MTLBuffer source, NSUInteger sourceOffset, 
              MTLBuffer destination, NSUInteger destinationOffset, 
              NSUInteger size) @selector("copyFromBuffer:sourceOffset:toBuffer:destinationOffset:size:");

    /**
        Encodes a command that copies slices of a texture to another texture’s slices.
    */
    void copy(MTLTexture source, NSUInteger sourceSlice, NSUInteger sourceLevel, 
              MTLTexture destination, NSUInteger destinationSlice, NSUInteger destinationLevel,
              NSUInteger sliceCount, NSUInteger levelCount) @selector("copyFromTexture:sourceSlice:sourceLevel:toTexture:destinationSlice:destinationLevel:sliceCount:levelCount:");

    /**
        Encodes a command that copies image data from a texture’s slice into another slice.
    */
    void copy(MTLTexture source, NSUInteger sourceSlice, NSUInteger sourceLevel, MTLOrigin sourceOrigin, MTLSize sourceSize, // Source
              MTLTexture destination, NSUInteger destinationSlice, NSUInteger destinationLevel, MTLOrigin destinationOrigin) // Destination
              @selector("copyFromTexture:sourceSlice:sourceLevel:sourceOrigin:sourceSize:toTexture:destinationSlice:destinationLevel:destinationOrigin:");

    /**
        Encodes a command to copy image data from a source buffer into a destination texture.
    */
    void copy(MTLBuffer source, NSUInteger sourceOffset, NSUInteger bytesPerRow, MTLOrigin bytesPerImage, MTLSize sourceSize, // Source
              MTLTexture destination, NSUInteger destinationSlice, NSUInteger destinationLevel, MTLOrigin destinationOrigin)  // Destination
              @selector("copyFromBuffer:sourceOffset:sourceBytesPerRow:sourceBytesPerImage:sourceSize:toTexture:destinationSlice:destinationLevel:destinationOrigin:");
              
    /**
        Encodes a command to copy image data from a source buffer into a destination texture.
    */
    void copy(MTLBuffer source, NSUInteger sourceOffset, NSUInteger bytesPerRow, MTLOrigin bytesPerImage, MTLSize sourceSize, // Source
              MTLTexture destination, NSUInteger destinationSlice, NSUInteger destinationLevel, MTLOrigin destinationOrigin,  // Destination
              MTLBlitOptions options) @selector("copyFromBuffer:sourceOffset:sourceBytesPerRow:sourceBytesPerImage:sourceSize:toTexture:destinationSlice:destinationLevel:destinationOrigin:options:");
              
    /**
        Encodes a command that copies image data from a texture slice to a buffer.
    */
    void copy(MTLTexture source, NSUInteger sourceSlice, NSUInteger sourceLevel, MTLOrigin sourceOrigin, MTLSize sourceSize, // Source
              MTLBuffer destination, NSUInteger destinationOffset, NSUInteger bytesPerRow, MTLOrigin bytesPerImage)          // Destination
              @selector("copyFromTexture:sourceSlice:sourceLevel:sourceOrigin:sourceSize:toBuffer:destinationOffset:destinationBytesPerRow:destinationBytesPerImage:");
              
    /**
        Encodes a command that copies image data from a texture slice to a buffer, 
        and provides options for special texture formats.
    */
    void copy(MTLTexture source, NSUInteger sourceSlice, NSUInteger sourceLevel, MTLOrigin sourceOrigin, MTLSize sourceSize, // Source
              MTLBuffer destination, NSUInteger destinationOffset, NSUInteger bytesPerRow, MTLOrigin bytesPerImage,          // Destination
              MTLBlitOptions options) @selector("copyFromTexture:sourceSlice:sourceLevel:sourceOrigin:sourceSize:toBuffer:destinationOffset:destinationBytesPerRow:destinationBytesPerImage:options:");

    /**
        Encodes a command that improves the performance of the GPU’s accesses to a texture.
    */
    void optimizeForGPU(MTLTexture texture) @selector("optimizeContentsForGPUAccess:");

    /**
        Encodes a command that improves the performance of the GPU’s accesses to a specific 
        portion of a texture.
    */
    void optimizeForGPU(MTLTexture texture, NSUInteger slice, NSUInteger level) @selector("optimizeContentsForGPUAccess:slice:level:");

    /**
        Encodes a command that improves the performance of the CPU’s accesses to a texture.
    */
    void optimizeForCPU(MTLTexture texture) @selector("optimizeContentsForCPUAccess:");

    /**
        Encodes a command that improves the performance of the CPU’s accesses to a specific 
        portion of a texture.
    */
    void optimizeForCPU(MTLTexture texture, NSUInteger slice, NSUInteger level) @selector("optimizeContentsForCPUAccess:slice:level:");

    /**
        Encodes a command that synchronizes the CPU’s copy of a managed resource, such as a 
        buffer or texture, so that it matches the GPU’s copy.
    */
    void synchronize(MTLResource resource) @selector("synchronizeResource:");

    /**
        Encodes a command that synchronizes a part of the CPU’s copy of a texture so that it 
        matches the GPU’s copy.
    */
    void synchronize(MTLTexture texture, NSUInteger slice, NSUInteger level) @selector("synchronizeTexture:slice:level:");

    /**
        Encodes a command that instructs the GPU to wait until a pass updates a fence.
    */
    void waitForFence(MTLFence fence) @selector("waitForFence:");

    /**
        Encodes a command that instructs the GPU to update a fence, which signals 
        passes waiting on the fence.
    */
    void updateFence(MTLFence fence) @selector("updateFence:");
}