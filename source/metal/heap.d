/**
    MTLHeap

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.heap;
import metal.allocation;
import metal.resource;
import metal.buffer;
import metal.texture;
import metal.types;
import metal.device;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    Describes the mode of operation for an MTLHeap.
*/
enum MTLHeapType : NSInteger {
    
    /**
        In this mode, resources are placed in the heap automatically.

        Automatically placed resources have optimal GPU-specific layout, 
        and may perform better than MTLHeapTypePlacement.
        This heap type is recommended when the heap primarily contains 
        temporary write-often resources.
    */
    Automatic = 0,
    
    /**
        In this mode, the app places resources in the heap.

        Manually placed resources allow the app to control memory usage 
        and heap fragmentation directly.
        This heap type is recommended when the heap primarily contains 
        persistent write-rarely resources.
    */
    Placement = 1,
    Sparse = 2,
}

/**
    A class used to indicate how a heap should be created.
*/
extern(Objective-C)
extern class MTLHeapDescriptor : NSObject, NSCopying {
nothrow @nogc:
public:

    // copyWithZone
    override id copyWithZone(NSZone* zone) @selector("copyWithZone:");

    /**
        Requested size of the heap's backing memory.

        Note:
            The size may be rounded up to GPU page granularity.
    */
    @property NSUInteger size();
    @property void size(NSUInteger);

    /**
        Storage mode for the heap. Default is $(D MTLStorageMode.Private).

        Note:
            All resources created from this heap share the same storage mode.
            $(D MTLStorageMode.Managed) and $(D MTLStorageMode.Memoryless) are 
            disallowed.
    */
    @property MTLStorageMode storageMode();
    @property void storageMode(MTLStorageMode);

    /**
        CPU cache mode for the heap. Default is $(D MTLCPUCacheMode.DefaultCache).

        Note:
            All resources created from this heap share the same cache mode.
            CPU cache mode is ignored for $(D MTLStorageMode.Private).
    */
    @property MTLCPUCacheMode cpuCacheMode();
    @property void cpuCacheMode(MTLCPUCacheMode);

    /**
        The sparse page size to use for resources created from the heap.
    */
    @property MTLSparsePageSize sparsePageSize();
    @property void sparsePageSize(MTLSparsePageSize);

    /**
        Set hazard tracking mode for the heap.
        The default value is $(D MTLHazardTrackingMode.Default).
    
        For heaps, $(D MTLHazardTrackingMode.Default) is treated as $(D MTLHazardTrackingMode.Untracked).
        Setting hazardTrackingMode to $(D MTLHazardTrackingMode.Tracked) causes 
        hazard tracking to be enabled heap.
        When a resource on a hazard tracked heap is modified, reads and writes from all resources
        suballocated on that heap will be delayed until the modification is complete.
        Similarly, modifying heap resources will be delayed until all in-flight reads 
        and writes from all resources suballocated on that heap have completed.
        For optimal performance, perform hazard tracking manually 
        through $(D MTLFence) or $(D MTLEvent) instead.
        All resources created from this heap shared the same hazard tracking mode.
    */
    @property MTLHazardTrackingMode hazardTrackingMode();
    @property void hazardTrackingMode(MTLHazardTrackingMode);

    /**
        A packed tuple of the storageMode, cpuCacheMode and hazardTrackingMode properties.

        Modifications to this property are reflected in the 
        other properties and vice versa.
    */
    @property MTLResourceOptions resourceOptions();
    @property void resourceOptions(MTLResourceOptions);

    /**
        The type of the heap. The default value is $(D MTLHeapType.Automatic).

        This constrains the resource creation functions that are available.
    */
    @property MTLHeapType type();
    @property void type(MTLHeapType);

    /**
        Specifies the largest sparse page size that the Metal heap supports.
    */
    version(Metal4)
    @property MTLSparsePageSize maxCompatiblePlacementSparsePageSize();
    @property void maxCompatiblePlacementSparsePageSize(MTLSparsePageSize);
}

/**
    A memory pool from which you can suballocate resources.
*/
extern(Objective-C)
extern interface MTLHeap : MTLAllocation {
@nogc nothrow:
public:

    /**
        The device this heap was created against. 
        
        This heap can only be used with this device.
    */
    @property MTLDevice device();

    /**
        A string to help identify this heap.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        Current heap storage mode, default is $(D MTLStorageMode.Private).

        Note:
            All resources created from this heap share the same storage mode.
    */
    @property MTLStorageMode storageMode();

    /**
        CPU cache mode for the heap. Default is $(D MTLCPUCacheMode.DefaultCache).

        Note:
            All resources created from this heap share the same cache mode.
    */
    @property MTLCPUCacheMode cpuCacheMode();

    /**
        Whether or not the heap is hazard tracked.

        Note:
            When a resource on a hazard tracked heap is modified, reads and writes
            from any other resource on that heap will be delayed until the 
            modification is complete.
            Similarly, modifying heap resources will be delayed until all in-flight 
            reads and writes from resources suballocated on that heap have completed.
            For optimal performance, perform hazard tracking manually through 
            $(D MTLFence) or $(D MTLEvent) instead.
            Resources on the heap may opt-out of hazard tracking individually when 
            the heap is hazard tracked, however resources cannot opt-in to hazard 
            tracking when the heap is not hazard tracked.
    */
    @property MTLHazardTrackingMode hazardTrackingMode();

    /**
        A packed tuple of the storageMode, cpuCacheMode and hazardTrackingMode properties.
    */
    @property MTLResourceOptions resourceOptions();

    /**
        Heap size in bytes, specified at creation time and rounded up to 
        device specific alignment.
    */
    @property NSUInteger size();

    /**
        The size in bytes, of all resources allocated from the heap.
    */
    @property NSUInteger usedSize();

    /**
        The size in bytes of the current heap allocation.
    */
    @property NSUInteger currentAllocatedSize();

    /**
        The type of the heap. The default value is $(D MTLHeapType.Automatic).
    */
    @property MTLHeapType type();

}
