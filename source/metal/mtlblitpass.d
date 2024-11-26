/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLRenderPass
*/
module metal.mtlblitpass;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    A configuration that instructs the GPU where to store counter data 
    from the beginning and end of a blit pass.
*/
extern(Objective-C)
extern class MTLBlitPassSampleBufferAttachmentDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLBlitPassSampleBufferAttachmentDescriptor alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLBlitPassSampleBufferAttachmentDescriptor init() @selector("init");

    /**
        An index within a counter sample buffer that tells the GPU where to 
        store counter data from the start of a blit pass.
    */
    @property NSUInteger startOfEncoderSampleIndex();
    @property void startOfEncoderSampleIndex(NSUInteger);

    /**
        An index within a counter sample buffer that tells the GPU where to 
        store counter data from the end of a blit pass.
    */
    @property NSUInteger endOfEncoderSampleIndex();
    @property void endOfEncoderSampleIndex(NSUInteger);

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    A container that stores an array of sample buffer attachments for a blit pass.
*/
extern(Objective-C)
extern class MTLBlitPassSampleBufferAttachmentDescriptorArray : NSObject {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLBlitPassSampleBufferAttachmentDescriptorArray alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLBlitPassSampleBufferAttachmentDescriptorArray init() @selector("init");

    /**
        Gets the MTLBlitPassSampleBufferAttachmentDescriptor at the specified index.
    */
    MTLBlitPassSampleBufferAttachmentDescriptor get(NSUInteger attachmentIndex) @selector("objectAtIndexedSubscript:");

    /*
        Sets the MTLBlitPassSampleBufferAttachmentDescriptor at the specified index.

        ### Note
        > This always uses 'copy' semantics.
        > It is safe to set the attachment state at any legal index to nil, 
        > which resets that attachment descriptor state to default values.
    */
    void set(MTLBlitPassSampleBufferAttachmentDescriptor attachment, NSUInteger attachmentIndex) @selector("setObject:atIndexedSubscript:");

    /**
        Gets the MTLBlitPassSampleBufferAttachmentDescriptor at the specified index.
    */
    extern(D)
    MTLBlitPassSampleBufferAttachmentDescriptor opIndex(size_t index) {
        return this.get(cast(NSUInteger)index);
    }

    /**
        Sets the MTLBlitPassSampleBufferAttachmentDescriptor at the specified index.
    */
    extern(D)
    void opIndexAssign(MTLBlitPassSampleBufferAttachmentDescriptor desc, size_t index) {
        this.set(desc, cast(NSUInteger)index);
    }

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}

/**
    A configuration you create to customize a blit command encoder, which affects the 
    runtime behavior of the blit pass you encode with it.
*/
extern(Objective-C)
extern class MTLBlitPassDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLBlitPassDescriptor alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLBlitPassDescriptor init() @selector("init");

    /**
        An array of counter sample buffer attachments that you configure for a blit pass.
    */
    @property MTLBlitPassSampleBufferAttachmentDescriptor sampleBufferAttachments() const;

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    id copyWithZone(NSZone* zone) @selector("copyWithZone:");
}