/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Core Metal Types
*/
module metal.types;
import foundation;
import metal;
import objc;

/**
    The coordinates for the front upper-left corner of a region.
*/
struct MTLOrigin {
@nogc nothrow:
    NSUInteger x;
    NSUInteger y;
    NSUInteger z;
}

/**
    The dimensions of an object.
*/
struct MTLSize {
@nogc nothrow:
    NSUInteger width;
    NSUInteger height;
    NSUInteger depth;
}

/**
    The bounds for a subset of an object's elements.

    Metal has many object types that represent arrays of discrete elements. 
    For example, a texture has an array of pixel elements, and a thread grid has an array 
    of computational threads. Use MTLRegion instances to describe subsets of these objects.

    The origin is the front upper-left corner of the region, and its extents go towards the 
    back lower-right corner. Conceptually, when using a MTLRegion instance to describe a 
    subset of an object, treat the object as a 3D array of elements, even if it has fewer 
    dimensions. 
    
    For a 2D object, set the z coordinate of the origin to 0 and the depth to 1. 
    For a 1D object, set the y and z coordinates of the origin to 0 and the height and 
    depth to 1.
*/
struct MTLRegion {
@nogc nothrow:
    MTLOrigin origin;
    MTLSize size;
}

/**
    A subpixel sample position for use in multisample antialiasing (MSAA).

    Subpixel sample positions are in a 16 x 16 grid across a pixel. 
    Each subsample position’s x and y values are in 1/16 increments in the floating-point range [0.0, 15.0/16.0). 
    The pixel’s origin point (0,0) is at the top-left corner.

    See [Positioning Samples Programmatically](https://developer.com/documentation/metal/render_passes/positioning_samples_programmatically) for the details on working with subpixels.
*/
struct MTLSamplePosition {
    float x;
    float y;
}

/**
    The size and alignment of a resource, in bytes.
*/
struct MTLSizeAndAlign {
    NSUInteger size;
    NSUInteger align_;
}

/**
    A Metal Resource ID
*/
struct MTLResourceID {
    ulong _impl;
}
