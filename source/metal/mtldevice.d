/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLDevice
*/
module metal.mtldevice;
import metal.mtlcommandqueue;
import metal.mtlresource;
import metal.mtlbuffer;
import metal.mtltexture;
import metal.mtllibrary;
import metal;
import iosurface;
import foundation;
import objc;


import core.attribute : selector, optional;

/**
    Represents the functionality for families of GPUs.

    Check whether a GPU supports the features of a specific family by calling 
    the [MTLDevice.supportsFamily] method.
*/
enum MTLGPUFamily : NSInteger {

    /**
        Represents the Apple family 1 GPU features that correspond to the Apple A7 GPUs.
    */
    Apple1 = 1001,
    
    /**
        Represents the Apple family 2 GPU features that correspond to the Apple A8 GPUs.
    */
    Apple2 = 1002,
    
    /**
        Represents the Apple family 3 GPU features that correspond to the Apple A9 and A10 GPUs.
    */
    Apple3 = 1003,
    
    /**
        Represents the Apple family 4 GPU features that correspond to the Apple A11 GPUs.
    */
    Apple4 = 1004,
    
    /**
        Represents the Apple family 5 GPU features that correspond to the Apple A12 GPUs.
    */
    Apple5 = 1005,
    
    /**
        Represents the Apple family 6 GPU features that correspond to the Apple A13 GPUs.
    */
    Apple6 = 1006,
    
    /**
        Represents the Apple family 7 GPU features that correspond to the Apple A14 and M1 GPUs.
    */
    Apple7 = 1007,
    
    /**
        Represents the Apple family 8 GPU features that correspond to the Apple A15, A16, and M2 GPUs.
    */
    Apple8 = 1008,
    
    /**
        Represents the Apple family 9 GPU features that correspond to the Apple A17, M3, and M4 GPUs.
    */
    Apple9 = 1009,
    
    /**
        Represents the Mac family 1 GPU features.
    */
    deprecated
    Mac1 = 2001,
    
    /**
        Represents the Mac family 2 GPU features.
    */
    Mac2 = 2002,
    
    /**
        Represents the Common family 1 GPU features.
    */
    Common1 = 3001,
    
    /**
        Represents the Common family 2 GPU features.
    */
    Common2 = 3002,
    
    /**
        Represents the Common family 3 GPU features.
    */
    Common3 = 3003,
    
    /**
        Represents a family 1 Mac GPU when running an app you built with Mac Catalyst.
    */
    deprecated
    MacCatalyst1 = 4001,
    
    /**
        Represents a family 2 Mac GPU when running an app you built with Mac Catalyst.
    */
    deprecated
    MacCatalyst2 = 4002,
    
    /**
        Represents the Metal 3 features.
    */
    Metal3 = 5001,
}

/**
    Indicates the location of the GPU relative to the system it’s connected to.

    Check the location of a GPU by checking the location 
    property of its [MTLDevice] instance.
*/
enum MTLDeviceLocation : NSUInteger {

    /**
        A location that indicates the GPU is permanently connected to the system internally.
    */
    BuiltIn = 0,

    /**
        A GPU location that indicates a person connected the GPU to a system’s internal slot.
    */
    Slot = 1,

    /**
        A GPU location that indicates a person connected the GPU to the system with an external 
        interface, such as Thunderbolt.
    */
    External = 2,

    /**
        A value that indicates the system can’t determine how the GPU connects to it.
    */
    Unspecified = NSUInteger.max,
}

/**
    Options that determine how Metal prepares the pipeline.
*/
enum MTLPipelineOption : NSUInteger {

    /**
        Don’t provide any reflection information.
    */
    None = 0,

    /**
        An option instance that provides argument information for 
        textures and threadgroup memory.
    */
    deprecated
    ArgumentInfo = 1,

    /**
        An option instance that provides detailed buffer type information for buffer arguments.
    */
    BufferTypeInfo = 2,

    /**
        An option that specifies that Metal only creates the pipeline state object if the 
        compiled shader is present inside a linked binary archive.
    */
    FailOnBinaryArchiveMiss = 4,

    /**
        (Undocumented by Apple)
    */
    BindingInfo = (1<<0),
}

/**
    The support level for read-write texture formats.
*/
enum MTLReadWriteTextureTier : NSUInteger {

    /**
        Read-write textures are not supported.
    */
    TierNone = 0,

    /**
        Tier 1 read/write textures are supported.
    */
    Tier1 = 1,

    /**
        Tier 2 read/write textures are supported.
    */
    Tier2 = 2,
}

/**
    The values that determine the limits and capabilities of argument buffers.

    See [Improving CPU Performance by Using Argument Buffers](https://developer.com/documentation/metal/buffers/improving_cpu_performance_by_using_argument_buffers?language=objc) 
    for more information about argument buffer tiers, limits, and capabilities. 
    Query the [MTLDevice.argumentBuffersSupport] property to determine argument buffer tier support for a given device.
*/
enum MTLArgumentBuffersTier : NSUInteger {

    /**
        Support for tier 1 argument buffers.
    */
    Tier1 = 0,

    /**
        Support for tier 2 argument buffers.
    */
    Tier2 = 1,
}

/**
    Options used when converting between a pixel-based region 
    within a texture to a tile-based region.
*/
enum MTLSparseTextureRegionAlignmentMode : NSUInteger {

    /**
        The tile region includes any partially covered tiles.
    */
    Outward = 0,

    /**
        The tile region ignores partially covered tiles.
    */
    Inward = 1,
}

/**
    The page size options, in kilobytes, for sparse textures.
*/
enum MTLSparsePageSize : NSInteger {

    /**
        Represents a sparse texture’s page size of 16 kilobytes.
    */
    Size16 = 101,

    /**
        Represents a sparse texture’s page size of 64 kilobytes.
    */
    Size64 = 102,

    /**
        Represents a sparse texture’s page size of 256 kilobytes.
    */
    Size256 = 103,
}

/**
    The expected sizes for a ray-tracing acceleration structure.
*/
struct MTLAccelerationStructureSizes {

    /**
        The size of the acceleration structure, in bytes.
    */
    NSUInteger accelerationStructureSize;

    /**
        The amount of scratch memory, in bytes, the GPU devices needs to 
        build the acceleration structure.
    */
    NSUInteger buildScratchBufferSize;

    /**
        The amount of scratch memory, in bytes, the GPU device needs to 
        refit the acceleration structure.
    */
    NSUInteger refitScratchBufferSize;
}

/**
    Options for different times when you can sample GPU counters.
*/
enum MTLCounterSamplingPoint : NSUInteger {

    /**
        Counter sampling is allowed at the start and end of a render pass’s 
        vertex and fragment stages, and at the start and end of compute and 
        blit passes.
    */
    AtStageBoundary = 0,

    /**
        Counter sampling is allowed between draw commands in a render pass.
    */
    AtDrawBoundary = 1,

    /**
        Counter sampling is allowed between kernel dispatches in a compute pass.
    */
    AtDispatchBoundary = 2,

    /**
        Counter sampling is allowed between tile dispatches in a render pass.
    */
    AtTileDispatchBoundary = 3,

    /**
        Counter sampling is allowed between blit commands in a blit pass.
    */
    AtBlitBoundary = 4,
}

/**
    A class that contains the architectural details of a GPU device.
*/
extern(Objective-C)
extern class MTLArchitecture : NSObject, NSCopying {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLArchitecture alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLArchitecture init() @selector("init");

    /**
        The name of a GPU device’s architecture.
    */
    @property NSString name() const;

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    The main Metal interface to a GPU that apps use to draw graphics and run computations in parallel.
*/
extern(Objective-C)
extern interface MTLDevice : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The maximum threadgroup memory available to a compute kernel, in bytes.
    */
    @property NSUInteger maxThreadgroupMemoryLength() const;

    /**
        The maximum number of threads along each dimension of a threadgroup.
    */
    @property MTLSize maxThreadsPerThreadgroup() const;

    /**
        A Boolean value that indicates whether the GPU device supports ray tracing.
    */
    @property bool supportsRaytracing() const;

    /**
        The maximum threadgroup memory available to a compute kernel, in bytes.
    */
    @property bool supportsPrimitiveMotionBlur() const;

    /**
        A Boolean value that indicates whether you can call ray-tracing functions 
        from a vertex or fragment shader.
    */
    @property bool supportsRaytracingFromRender() const;

    /**
        A Boolean value that indicates whether the GPU can allocate 32-bit integer 
        texture formats and resolve to 32-bit floating-point texture formats.
    */
    @property bool supports32BitMSAA() const;

    /**
        A Boolean value that indicates whether the GPU can compute multiple 
        interpolations of a fragment function’s input.
    */
    @property bool supportsPullModelInterpolation() const;

    /**
        A Boolean value that indicates whether the GPU supports barycentric coordinates.
    */
    @property bool supportsShaderBarycentricCoordinates() const;

    /**
        A Boolean value that indicates whether the GPU supports programmable sample positions.
    */
    @property bool programmableSamplePositionsSupported() const @selector("areProgrammableSamplePositionsSupported");

    /**
        A Boolean value that indicates whether the GPU supports raster order groups.
    */
    @property bool rasterOrderGroupsSupported() const @selector("areRasterOrderGroupsSupported");

    /**
        A Boolean value that indicates whether the GPU can filter a texture with a 
        32-bit floating-point format.
    */
    @property bool supports32BitFloatFiltering() const;

    /**
        A Boolean value that indicates whether you can use textures that use BC compression.
    */
    @property bool supportsBCTextureCompression() const;

    /**
        A Boolean value that indicates whether the GPU can filter a texture with a 
        32-bit floating-point format.
    */
    @property bool depth24Stencil8PixelFormatSupported() const @selector("isDepth24Stencil8PixelFormatSupported");

    /**
        A Boolean value that indicates whether you can query the texture level of 
        detail from within a shader.
    */
    @property bool supportsQueryTextureLOD() const;

    /**
        The GPU device’s texture support tier.
    */
    @property MTLReadWriteTextureTier readWriteTextureSupport() const;

    /**
        A Boolean value that indicates whether the GPU device supports 
        pointers to compute kernel functions.
    */
    @property bool supportsFunctionPointers() const;

    /**
        A Boolean value that indicates whether the GPU device 
        supports pointers to render functions.
    */
    @property bool supportsFunctionPointersFromRender() const;

    /**
        The total amount of memory, in bytes, the GPU device is using for 
        all of its resources.
    */
    @property NSUInteger currentAllocatedSize() const;

    /**
        An approximation of how much memory, in bytes, this GPU device 
        can allocate without affecting its runtime performance.
    */
    @property ulong recommendedMaxWorkingSetSize() const;

    /**
        A Boolean value that indicates whether the GPU shares all of 
        its memory with the CPU.
    */
    @property bool hasUnifiedMemory() const;

    /**
        The highest theoretical rate, in bytes per second, the system can copy between 
        system memory and the GPU’s dedicated memory (VRAM).
    */
    @property ulong maxTransferRate() const;

    /**
        The full name of the GPU device.
    */
    @property NSString name() const;

    /**
        The architectural details of the GPU device.
    */
    @property MTLArchitecture architecture() const;

    /**
        The GPU device’s registry identifier.
    */
    @property ulong registryID() const;

    /**
        The physical location of the GPU relative to the system.
    */
    @property MTLDeviceLocation location() const;

    /**
        A specific GPU position based on its general location.
    */
    @property NSUInteger locationNumber() const;

    /**
        A Boolean value that indicates whether the GPU lowers its 
        performance to conserve energy.
    */
    @property bool lowPower() const @selector("isLowPower");

    /**
        A Boolean value that indicates whether the GPU is removable.
    */
    @property bool removable() const @selector("isRemovable");

    /**
        A Boolean value that indicates whether a GPU device doesn’t 
        have a connection to a display.
    */
    @property bool headless() const @selector("isHeadless");

    /**
        The peer group ID the GPU belongs to, if applicable.

        A group ID value of 0 indicates the GPU isn’t in a peer group. 
        Otherwise, the GPU is in a peer group and the value is the group’s ID. 
        All other GPUs in the same peer group have the same group ID.
    */
    @property ulong peerGroupID() const;

    /**
        The total number of GPUs in the peer group, if applicable.

        A peer count value of 0 indicates the GPU isn’t in a peer group. 
        Otherwise, the GPU is in a peer group and the value represents the 
        total number of GPUs in the group, including this one.
    */
    @property uint peerCount() const;

    /**
        The unique identifier for a GPU in a peer group.

        If the GPU is part of a peer group (see peerGroupID or peerCount) the
        peer index is the GPU’s unique value within the group in the 
        range [0, peerCount).
    */
    @property uint peerIndex() const;

    /**
        How many concurrent compilation tasks the device supports.
    */
    @property NSUInteger maximumConcurrentCompilationTaskCount() const;

    /**
        Whether it's recommended that the developer maximizes concurrent
        compilation tasks.
    */
    @property bool shouldMaximizeConcurrentCompilation() const;

    /**
        Returns a Boolean value that indicates whether the GPU device supports the 
        feature set of a specific GPU family.
    */
    bool supportsFamily(MTLGPUFamily family) @selector("supportsFamily:");

    /**
        Returns a Boolean value that indicates whether the GPU supports an amplification factor.
    */
    bool supportsVertexAmplificationCount(NSUInteger count) const @selector("supportsVertexAmplificationCount:");

    /**
        The largest amount of memory, in bytes, that a GPU device can allocate to a buffer instance.
    */
    @property NSUInteger maxBufferLength() const;

    /**
        Returns the size, in bytes, of a sparse tile the GPU device creates using a default page size.
    */
    @property NSUInteger sparseTileSizeInBytes() const;

    /**
        The maximum number of unique argument buffer samplers per app.
    */
    @property NSUInteger maxArgumentBufferSamplerCount() const;

    /**
        A Boolean value that indicates whether the GPU device can create and use 
        dynamic libraries in compute pipelines.
    */
    @property bool supportsDynamicLibraries() const;

    /**
        A Boolean value that indicates whether the GPU device can create and use 
        dynamic libraries in render pipelines.
    */
    @property bool supportsRenderDynamicLibraries() const;

    /**
        Creates the system default device.
    */
    extern(D)
    final static MTLDevice createSystemDefaultDevice() {
        return MTLCreateSystemDefaultDevice();
    }

    /**
        Returns an NSArray over all the MTLDevice instances
        in the system.
    */
    extern(D)
    @property
    final static NSArray!MTLDevice allDevices() {
        return MTLCopyAllDevices();
    }

    /**
        Creates a queue you use to submit rendering and computation commands to a GPU.
    */
    MTLCommandQueue newCommandQueue() @selector("newCommandQueue");

    /**
        Creates a queue you use to submit rendering and computation commands to a GPU.
    */
    MTLCommandQueue newCommandQueue(NSUInteger maxCommandBufferCount) @selector("newCommandQueueWithMaxCommandBufferCount:");

    /**
        Creates a buffer the method clears with zero values.
    */
    MTLBuffer newBuffer(NSUInteger length, MTLResourceOptions options) @selector("newBufferWithLength:options:");

    /**
        Allocates a new buffer of a given length and initializes 
        its contents by copying existing data into it.
    */
    MTLBuffer newBuffer(void* data, NSUInteger length, MTLResourceOptions options) @selector("newBufferWithBytes:length:options:");

    /**
        Creates a new texture instance.
    */
    MTLTexture newTexture(MTLTextureDescriptor descriptor) @selector("newTextureWithDescriptor:");

    /**
        Creates a texture instance that uses an IOSurface to store its underlying data.
    */
    version(IOSurface)
    MTLTexture newTexture(MTLTextureDescriptor descriptor, IOSurfaceRef surface, NSUInteger plane) @selector("newTextureWithDescriptor:iosurface:plane:");

    /**
        Creates a texture that you can share across process boundaries.
    */
    MTLTexture newSharedTexture(MTLTextureDescriptor descriptor) @selector("newSharedTextureWithDescriptor:");

    /**
        Creates a texture that references a shared texture.
    */
    MTLTexture newSharedTexture(MTLSharedTextureHandle descriptor) @selector("newSharedTextureWithHandle:");

    /**
        Returns the minimum alignment the GPU device requires to create a linear texture from a buffer.
    */
    NSUInteger minimumLinearTextureAlignmentForPixelFormat(MTLPixelFormat format) @selector("minimumLinearTextureAlignmentForPixelFormat:");

    /**
        Returns the minimum alignment the GPU device requires to create a texture buffer from a buffer.
    */
    NSUInteger minimumTextureBufferAlignmentForPixelFormat(MTLPixelFormat format) @selector("minimumTextureBufferAlignmentForPixelFormat:");

    /**
        Creates a Metal library instance that contains the functions 
        from your app’s default Metal library.
    */
    MTLLibrary newLibrary() @selector("newDefaultLibrary");

    /**
        Synchronously creates a Metal library instance by compiling 
        the functions in a source string.
    */
    MTLLibrary newLibrary(NSString source, MTLCompileOptions options, ref NSError error) @selector("newLibraryWithSource:options:error:");
}

/**
    Returns the device instance Metal selects as the default.
*/
extern(C) MTLDevice MTLCreateSystemDefaultDevice() @nogc nothrow; // @suppress(dscanner.style.phobos_naming_convention)

/**
    Returns an array of all the Metal device instances in the system.
*/
extern(C) NSArray!MTLDevice MTLCopyAllDevices() @nogc nothrow; // @suppress(dscanner.style.phobos_naming_convention)