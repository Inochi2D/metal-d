/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTKMesh, MTKSubmesh, MTKMeshBuffer, MTKMeshBufferAllocator
*/
module metalkit.mtkmodel;
import metal.mtldevice;
import foundation;
import metalkit;
import metal;
import objc;

import core.attribute : selector, optional;

version(MetalKit):


/**
    An interface for allocating a MetalKit buffer that backs the vertex data of 
    a Model I/O mesh, suitable for use in a Metal app.
*/
extern(Objective-C)
extern class MTKMeshBufferAllocator : NSObject {

    /**
        Returns a new instance of the receiving class.
    */
    override static MTKMeshBufferAllocator alloc() @selector("alloc");

    /**
        Initializes a new texture loader object.
    */
    MTKMeshBufferAllocator init(MTLDevice device) @selector("initWithDevice:");

    /**
        The device object that the texture loader uses to create textures.
    */
    @property MTLDevice device() const @selector("device");
}

// TODO: The rest of MTK Model handling.

/**
    Constants used to declare Model Errors.
*/
alias MTKModelError = NSString;

/**
    The error domain used by MetalKit when returning texture loading errors.
*/
extern(C) extern const __gshared MTKModelError MTKModelErrorDomain;

/**
    The key used to retrieve an error string from an error object’s userInfo dictionary.
*/
extern(C) extern const __gshared MTKModelError MTKModelErrorKey;