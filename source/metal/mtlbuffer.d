/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLTexture
*/
module metal.mtlbuffer;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    A resource that stores data in a format defined by your app.
*/
extern(Objective-C)
extern interface MTLBuffer : MTLResource {
@nogc nothrow:
public:

    /**
        Gets the system address of the buffer’s storage allocation.
    */
    @property void* contents();

    /**
        The logical size of the buffer, in bytes.
    */
    @property NSUInteger length() const;

    /**
        The logical size of the buffer, in bytes.
    */
    @property ulong gpuAddress() const;

    /**
        The buffer on another GPU that the buffer was created from, if any.
    */
    @property MTLBuffer remoteStorageBuffer() const;

    /**
        Creates a texture that shares its storage with the buffer.
    */
    MTLTexture newTexture(MTLTextureDescriptor descriptor, NSUInteger offset, NSUInteger bytesPerRow) @selector("newTextureWithDescriptor:offset:bytesPerRow:");

    /**
        Creates a remote view of the buffer for another GPU in the same peer group.
    */
    MTLBuffer newRemoteBufferView(MTLDevice device) @selector("newRemoteBufferViewForDevice:");

    /**
        Informs the GPU that the CPU has modified a section of the buffer.
    */
    void didModifyRange(NSRange range) @selector("didModifyRange:");

    /**
        Adds a debug marker string to a specific buffer range.
    */
    void addDebugMarker(NSString marker, NSRange range) @selector("addDebugMarker:range:");

    /**
        Removes all debug marker strings from the buffer.
    */
    void removeAllDebugMarkers() @selector("removeAllDebugMarkers");
}