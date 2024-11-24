/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTKTextureLoader
*/
module metalkit.mtktextureloader;
import metal.mtldevice;
import metal.mtltexture;
import foundation;
import metalkit;
import metal;
import objc;

import core.attribute : selector, optional;

version(MetalKit):

/**
    The signature for the block executed after an asynchronous loading operation for a single texture has completed.
*/
alias MTKTextureLoaderCallback = Block!(void, MTLTexture, NSError*);

/**
    The signature for the block executed after an asynchronous loading operation for multiple textures has completed.
*/
alias MTKTextureLoaderArrayCallback = Block!(void, NSArray!MTLTexture, NSError*);

/**
    An object that creates textures from existing data in common image formats.

    Use the MTKTextureLoader class to create a Metal texture from existing image data.

    This class supports common file formats, like PNG, JPEG, and TIFF. It also loads image data from KTX and PVR files, 
    asset catalogs, Core Graphics images, and other sources. 
    It infers the output texture format and pixel format from the image data.

    You create textures synchronously or asynchronously using MTKTextureLoader methods that return MTLTexture instances. 
    Pass options to these methods that customize the image-loading and texture-creation process.

    First create an MTKTextureLoader instance, passing the device that it uses to create textures. 
    Then use one of the texture loader’s methods to create a texture. 
    The code example below synchronously creates a texture from data at a URL, using the default options:

    ```d
        MTLTexture loadTextureUsingMetalKit(NSURL url, MTLDevice device) @selector("loadTextureUsingMetalKit:device:") {
            NSError error;
            MTKTextureLoader loader = MTKTextureLoader.alloc.init(device);

            MTLTexture texture = loader.load(url, null, &error);
            if (!texture) 
                NSLog("Error creating the texture from %@: %@", urk.absoluteString, error.localizedDescription);
            
            return texture;
        }
    ```
*/
extern(Objective-C)
extern class MTKTextureLoader : NSObject {

    /**
        Returns a new instance of the receiving class.
    */
    override static MTKTextureLoader alloc() @selector("alloc");

    /**
        Initializes a new texture loader object.
    */
    MTKTextureLoader init(MTLDevice device) @selector("initWithDevice:");

    /**
        The device object that the texture loader uses to create textures.
    */
    @property MTLDevice device() const @selector("device");

    /**
        Synchronously loads image data and creates a new Metal texture from a given URL.
    */
    MTLTexture load(NSURL url, NSDictionary!(NSString, id) options, NSError* error) 
        @selector("newTextureWithContentsOfURL:options:error:");

    /**
        Asynchronously loads image data and creates a new Metal texture from a given URL.
    */
    MTLTexture load(NSURL url, NSDictionary!(NSString, id) options, MTKTextureLoaderCallback completionHandler) 
        @selector("newTextureWithContentsOfURL:options:completionHandler:");

    /**
        Synchronously loads image data and creates new Metal textures from the specified list of URLs.
    */
    NSArray!MTLTexture load(NSArray!NSURL urls, NSDictionary!(NSString, id) options, NSError* error) 
        @selector("newTexturesWithContentsOfURLs:options:error:");

    /**
        Asynchronously loads image data and creates new Metal textures from the specified list of URLs.
    */
    NSArray!MTLTexture load(NSArray!NSURL urls, NSDictionary!(NSString, id) options, MTKTextureLoaderArrayCallback completionHandler) 
        @selector("newTexturesWithContentsOfURLs:options:error:");
}

/**
    Errors returned by the texture loader.
*/
alias MTKTextureLoaderError = NSString;

/**
    The error domain used by MetalKit when returning texture loading errors.
*/
extern(C) extern const __gshared MTKTextureLoaderError MTKTextureLoaderErrorDomain;

/**
    The key used to retrieve an error string from an error object’s userInfo dictionary.
*/
extern(C) extern const __gshared MTKTextureLoaderError MTKTextureLoaderErrorKey;