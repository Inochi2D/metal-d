/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLTexture
*/
module metal.mtltexture;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;


enum MTLTextureType : NSUInteger {
    Type1D = 0,
    Type1DArray = 1,
    Type2D = 2,
    Type2DArray = 3,
    Type2DMultisample = 4,
    TypeCube = 5,
    TypeCubeArray = 6,
    Type3D = 7,
    Type2DMultisampleArray = 8,
    TypeTextureBuffer = 9,
}

enum MTLTextureSwizzle : ubyte {
    Zero = 0,
    One = 1,
    Red = 2,
    Green = 3,
    Blue = 4,
    Alpha = 5,
}

struct MTLTextureSwizzleChannels {
@nogc nothrow:
    MTLTextureSwizzle red;
    MTLTextureSwizzle green;
    MTLTextureSwizzle blue;
    MTLTextureSwizzle alpha;
}

enum MTLTextureUsage : NSUInteger {
    Unknown = 0,
    ShaderRead = 1,
    ShaderWrite = 2,
    RenderTarget = 4,
    PixelFormatView = 16,
    ShaderAtomic = 32,
}

enum MTLTextureCompressionType : NSInteger {
    Lossless = 0,
    Lossy = 1,
}

/**
    An object that you use to configure new Metal texture objects.

    To create a new texture, first create a MTLTextureDescriptor object and set its property values. 
    Then, call either the [newTextureWithDescriptor] method of a [MTLDevice] object, 
    or the [newTextureWithDescriptor] method of a [MTLBuffer] object.

    When you create a texture, Metal copies property values from the descriptor into the new texture. 
    You can reuse a MTLTextureDescriptor object, modifying its property values as needed, 
    to create more MTLTexture objects, without affecting any textures you already created.
*/
extern(Objective-C)
extern class MTLTextureDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLTextureDescriptor alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLTextureDescriptor init() @selector("init");

    /**
        The dimension and arrangement of texture image data.
    */
    @property MTLTextureType textureType();
    @property void textureType(MTLTextureType);

    /**
        The size and bit layout of all pixels in the texture.
    */
    @property MTLPixelFormat pixelFormat();
    @property void pixelFormat(MTLPixelFormat);

    /**
        The width of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger width();
    @property void width(NSUInteger);

    /**
        The height of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger height();
    @property void height(NSUInteger);

    /**
        The depth of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger depth();
    @property void depth(NSUInteger);

    /**
        The number of mipmap levels for this texture.
    */
    @property NSUInteger mipmapLevelCount();
    @property void mipmapLevelCount(NSUInteger);

    /**
        The number of samples in each fragment. 
    */
    @property NSUInteger sampleCount();
    @property void sampleCount(NSUInteger);

    /**
        The number of array elements for this texture. 
    */
    @property NSUInteger arrayLength();
    @property void arrayLength(NSUInteger);

    /**
        Options that determine how you can use the texture.
    */
    @property MTLTextureUsage usage();
    @property void usage(MTLTextureUsage);

    /**
        The type of compression to use for the texture
    */
    @property MTLTextureCompressionType compressionType();
    @property void compressionType(MTLTextureCompressionType);

    /**
        The pattern you want the GPU to apply to pixels when you 
        read or sample pixels from the texture.
    */
    @property MTLTextureSwizzleChannels swizzle();
    @property void swizzle(MTLTextureSwizzleChannels);

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    A resource that holds formatted image data.

    # Overview
    Don’t implement this protocol yourself; instead, use one of the following methods to create a MTLTexture instance:

        * Create a [MTLTextureDescriptor] to describe the texture’s properties and then call the  
          [MTLDevice.newTexture] method of the MTLDevice to create the texture.
        
        * To create a texture that uses an existing [IOSurface] to hold the texture data, create a [MTLTextureDescriptor]    
          to describe the image data in the surface.  
          [MTLDevice.newTexture] method of the MTLDevice to create the texture while passing the IOSurface.

        * To create a texture that reinterprets another texture’s data as if it had a different format,  
          call one of the [MTLTexture.newTextureView] methods on a [MTLTexture] instance.  
          You must choose a pixel format for the new texture compatible with the source texture’s pixel format.  
          The new texture shares the same storage allocation as the source texture.  
          If you make changes to the new texture, the source texture reflects those changes, and vice versa.

        * To create a texture that uses an MTLBuffer instance’s contents to hold pixel data,  
          create a [MTLTextureDescriptor] to describe the texture’s properties.  
          Then call the [MTLBuffer.newTexture] method on the buffer object.  
          The new texture object shares the storage allocation of the source buffer object.  
          If you make changes to the texture, the buffer reflects those changes, and vice versa.

    After you create a [MTLTexture] object, most of its characteristics, such as its size, type, and pixel format are all immutable. 
    Only the texture’s pixel data is mutable.

    To copy pixel data from system memory into the texture, call [MTLTexture.replaceRegion].
    To copy pixel data back to system memory, call one of the [MTLTexture.getBytes] methods.
*/
extern(Objective-C)
extern interface MTLTexture : MTLResource {
@nogc nothrow:
public:

    /**
        The dimension and arrangement of the texture image data.
    */
    @property MTLTextureType textureType() const;

    /**
        The format of pixels in the texture.
    */
    @property MTLPixelFormat pixelFormat() const;

    /**
        The width of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger width() const;

    /**
        The height of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger height() const;

    /**
        The depth of the texture image for the base level mipmap, in pixels.
    */
    @property NSUInteger depth() const;

    /**
        The number of mipmap levels in the texture.
    */
    @property NSUInteger mipmapLevelCount() const;

    /**
        The number of slices in the texture array.
    */
    @property NSUInteger arrayLength() const;

    /**
        The number of samples in each pixel.
    */
    @property NSUInteger sampleCount() const;

    /**
        A Boolean value that indicates whether the texture can 
        only be used as a render target. 
    */
    @property bool framebufferOnly() const @selector("isFramebufferOnly");

    /**
        Options that determine how you can use the texture.
    */
    @property MTLTextureUsage usage() const;

    /**
        A Boolean value indicating whether the GPU is allowed to 
        adjust the contents of the texture to improve GPU performance.
    */
    @property bool allowGPUOptimizedContents() const;

    /**
        A Boolean indicating whether this texture can be shared with 
        other processes.
    */
    @property bool shareable() const @selector("isShareable");

    /**
        The pattern that the GPU applies to pixels when you 
        read or sample pixels from the texture.
    */
    @property MTLTextureSwizzleChannels swizzle() const;

    /**
        A reference to the IOSurface the texture was created from, if any.
    */
    version(IOSurface)
    @property IOSurfaceRef iosurface() const;

    /**
        The plane of the IOSurface to reference if any.
    */
    version(IOSurface)
    @property NSUInteger iosurfacePlane() const;

    /**
        The parent texture used to create this texture, if any.
    */
    @property MTLTexture parentTexture() const;

    /**
        The base level of the parent texture used to create this texture.
    */
    @property NSUInteger parentRelativeLevel() const;

    /**
        The base slice of the parent texture used to create this texture.
    */
    @property NSUInteger parentRelativeSlice() const;

    /**
        The source buffer used to create this texture, if any.
    */
    @property MTLBuffer buffer() const;

    /**
        The offset in the source buffer where the texture’s data comes from.
    */
    @property NSUInteger bufferOffset() const;

    /**
        The number of bytes in each row of the texture’s source buffer.
    */
    @property NSUInteger bufferBytesPerRow() const;

    /**
        The type of compression to use for the texture
    */
    @property MTLTextureCompressionType compressionType() const;

    /**
        A Boolean value that indicates whether this is a sparse texture.
    */
    @property bool isSparse() const;

    /**
        The index of the first mipmap in the tail.
    */
    @property NSUInteger firstMipmapInTail() const;

    /**
        The size of the sparse texture tail, in bytes.
    */
    @property NSUInteger tailSizeInBytes() const;

    /**
        The GPU resource ID.
    */
    @property MTLResourceID gpuResourceID() const;

    /**
        Creates a new texture handle from a shareable texture.
    */
    MTLSharedTextureHandle newSharedTextureHandle() @selector("newSharedTextureHandle");

    /**
        The texture on another GPU that the texture was created from, if any.
    */
    @property MTLTexture remoteStorageTexture() const;

    /**
        Creates a remote texture view for another GPU in the same peer group.
    */
    MTLTexture newRemoteTextureView(MTLDevice device) @selector("newRemoteTextureViewForDevice:");

    /**
        Copies pixel data into a section of a texture slice.
    */
    void replace(MTLRegion region, NSUInteger level, NSUInteger slice, const(void)* pixels, NSUInteger bytesPerRow, NSUInteger bytesPerImage) @selector("replaceRegion:mipmapLevel:slice:withBytes:bytesPerRow:bytesPerImage:");

    /**
        Copies a block of pixels into a section of texture slice 0.
    */
    void replace(MTLRegion region, NSUInteger level, const(void)* pixels, NSUInteger bytesPerRow) @selector("replaceRegion:mipmapLevel:withBytes:bytesPerRow:");

    /**
        Copies pixel data from the texture to a buffer in system memory.
    */
    void getBytes(void* destination, NSUInteger bytesPerRow, NSUInteger bytesPerImage, MTLRegion region, NSUInteger level, NSUInteger slice) @selector("getBytes:bytesPerRow:bytesPerImage:fromRegion:mipmapLevel:slice:");

    /**
        Copies pixel data from the first slice of the texture to a buffer in system memory.
    */
    void getBytes(void* destination, NSUInteger bytesPerRow, MTLRegion region, NSUInteger level) @selector("getBytes:bytesPerRow:fromRegion:mipmapLevel:");
}

/**
    A texture handle that can be shared across process address space boundaries.

    MTLSharedTextureHandle objects may be passed between processes using 
    XPC connections and then used to create a reference to the texture in another process. 

    The texture in the other process must be created using the same MTLDevice on which the 
    shared texture was originally created. To identify which device it was created on, you can use 
    the device property of the MTLSharedTextureHandle object.
*/
extern(Objective-C)
extern class MTLSharedTextureHandle : NSObject, NSSecureCoding {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLSharedTextureHandle alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLSharedTextureHandle init() @selector("init");

    /**
        A Boolean value that indicates whether or not the class 
        supports secure coding.
    */
    @property bool supportsSecureCoding();
    
    /**
        Encodes the receiver using a given archiver.
    */
    void encodeWithCoder(NSCoder coder) @selector("encodeWithCoder:");

    /**
        The device object that created the texture.
    */
    @property MTLDevice device() const;

    /**
        A string that identifies the texture.
    */
    @property NSString label() const;
}