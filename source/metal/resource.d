/**
    MTLResource

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.resource;
import metal.device;
import foundation;
import objc;

import core.attribute : selector, optional;

public import metal.allocation;
public import metal.types : MTLResourceID;

/**
    Options for setPurgeable call.
*/
enum MTLPurgeableState : NSUInteger {
    
    /**
        The contents of this resource may not be discarded.
    */
    KeepCurrent = 1,
    
    /**
        The contents of this resource may be discarded.
    */
    NonVolatile = 2,
    
    /**
        The contents of this are discarded.
    */
    Volatile = 3,
    
    /**
        The purgeabelity state is not changed.
    */
    Empty = 4,
}

/**
    Describes what CPU cache mode is used for the CPU's mapping of a texture resource.
*/
enum MTLCPUCacheMode : NSUInteger {
    
    /**
        Write combined memory is optimized for resources that the CPU will write into, but never read.  
        On some implementations, writes may bypass caches avoiding cache pollution, and reads perform very poorly.
    */
    DefaultCache = 0,
    
    /**
        Applications should only investigate changing the cache mode if writing to normally cached buffers is 
        known to cause performance issues due to cache pollution, as write combined memory can have surprising performance pitfalls.  
        Another approach is to use non-temporal stores to normally cached memory (STNP on ARMv8, _mm_stream_* on x86_64).
    */
    WriteCombined = 1,
}

/**
    Describes how hazard tracking is performed.
*/
enum MTLHazardTrackingMode : NSUInteger {

    /**
        The default hazard tracking mode for the context. Refer to the usage of the field for semantics.
    */
    Default = 0,

    /**
        Do not perform hazard tracking.
    */
    Untracked = 1,
    
    /**
        Do perform hazard tracking.
    */
    Tracked = 2,
}

/**
    Describes location and CPU mapping of MTLTexture.
*/
enum MTLStorageMode : NSUInteger {
    
    /**
        In this mode, CPU and device will nominally both use the same underlying memory when accessing the contents of the texture resource.
        However, coherency is only guaranteed at command buffer boundaries to minimize the required flushing of CPU and GPU caches.
        This is the default storage mode for iOS Textures.
    */
    Shared  = 0,
    
    /**
        This mode relaxes the coherency requirements and requires that the developer make explicit requests to maintain
        coherency between a CPU and GPU version of the texture resource.  In order for CPU to access up to date GPU results,
        first, a blit synchronizations must be completed (see synchronize methods of MTLBlitCommandEncoder).
        Blit overhead is only incurred if GPU has modified the resource.
        This is the default storage mode for OS X Textures.
    */
    Managed = 1,
    
    /**
        This mode allows the texture resource data to be kept entirely to GPU (or driver) private memory that will never be accessed by 
        the CPU directly, so no coherency of any kind must be maintained.
    */
    Private = 2,
    
    /**
        This mode allows creation of resources that do not have a GPU or CPU memory backing, but do have on-chip storage for TBDR
        devices. The contents of the on-chip storage is undefined and does not persist, but its configuration is controlled by the
        MTLTexture descriptor. Textures created with MTLStorageModeMemoryless dont have an IOAccelResource at any point in their
        lifetime. The only way to populate such resource is to perform rendering operations on it. Blit operations are disallowed.
    */
    Memoryless = 3,
}

enum MTLResourceCPUCacheModeShift          =  0;
enum MTLResourceCPUCacheModeMask           =  (0xfUL << MTLResourceCPUCacheModeShift);

enum MTLResourceStorageModeShift           =  4;
enum MTLResourceStorageModeMask            =  (0xfUL << MTLResourceStorageModeShift);

enum MTLResourceHazardTrackingModeShift    =  8;
enum MTLResourceHazardTrackingModeMask     =  (0x3UL << MTLResourceHazardTrackingModeShift);

/**
    A set of optional arguments to influence the creation of a 
    MTLResource (MTLTexture or MTLBuffer)
*/
enum MTLResourceOptions : NSUInteger {
    CacheModeDefaultCache        = MTLCPUCacheMode.DefaultCache  << MTLResourceCPUCacheModeShift,
    CacheModeWriteCombined       = MTLCPUCacheMode.WriteCombined << MTLResourceCPUCacheModeShift,

    StorageModeShared            = MTLStorageMode.Shared     << MTLResourceStorageModeShift,
    StorageModeManaged           = MTLStorageMode.Managed    << MTLResourceStorageModeShift,
    StorageModePrivate           = MTLStorageMode.Private    << MTLResourceStorageModeShift,
    StorageModeMemoryless        = MTLStorageMode.Memoryless << MTLResourceStorageModeShift,    
    
    HazardTrackingModeDefault    = MTLHazardTrackingMode.Default << MTLResourceHazardTrackingModeShift,
    HazardTrackingModeUntracked  = MTLHazardTrackingMode.Untracked << MTLResourceHazardTrackingModeShift,
    HazardTrackingModeTracked    = MTLHazardTrackingMode.Tracked << MTLResourceHazardTrackingModeShift,
}

/**
    An allocation of memory accessible to a GPU.
*/
extern(Objective-C)
extern interface MTLResource : MTLAllocation {
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
        The distance, in bytes, from the beginning of the heap to the first byte of the resource, 
        if you allocated the resource on a heap.
    */
    @property NSUInteger heapOffset() const;

    /**
        Allows future heap resource allocations to alias against the resource’s memory, reusing it.
    */
    void makeAliasable() @selector("makeAliasable");

    /**
        A Boolean value that indicates whether future heap resource allocations 
        may alias against the resource’s memory.
    */
    bool isAliasable() @selector("isAliasable");
}