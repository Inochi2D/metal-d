/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Bindings to Apple's IOSurface API.
*/
module iosurface;
import corefoundation.cfstring;
import corefoundation.cfdictionary;
import corefoundation;
import mach.ports;
import core.sys.darwin.mach.kern_return;
import objc.os;
import objc.basetypes;

version(IOSurface):
mixin LinkFramework!("IOSurface");

/**
    An IOSurface handle.
*/
alias IOSurfaceRef = CFTypeRef;

/**
    An IOSurface identifier.
*/
alias IOSurfaceID = uint;

enum IOSurfaceComponentName : int {
    Unknown = 0,
    Alpha = 1,
    Red = 2,
    Green = 3,
    Blue = 4,
    Luma = 5,
    ChromaRed = 6,
    ChromaBlue = 7,
}

enum IOSurfaceComponentType : int {
    Unknown = 0,
    UnsignedInteger = 1,
    SignedInteger = 2,
    Float = 3,
}

enum IOSurfaceComponentRange : int {
    Unknown = 0,
    FullRange = 1,
    VideoRange = 2,
    WideRange = 3,
}

enum IOSurfaceSubsampling : int {
    SubsamplingUnknown = 0,
    SubsamplingNone = 1,
    Subsampling422 = 2, 
    Subsampling420 = 3,
    Subsampling411 = 4,
}

enum IOSurfaceLockOptions : uint {    
	ReadOnly  =		0x00000001,
	AvoidSync =		0x00000002
}

extern(C):


//
//      GLOBAL CONSTANTS
//

/**
    CFNumber of the total allocation size of the buffer including all planes.    
    Defaults to BufferHeight * BytesPerRow if not specified.
    
    Must be specified for dimensionless IOSurfaces.
*/
extern __gshared const CFStringRef kIOSurfaceAllocSize;

/**
    CFNumber for the width of the IOSurface buffer in pixels.
    
    Required for planar IOSurfaces.
*/
extern __gshared const CFStringRef kIOSurfaceWidth;

/**
    CFNumber for the height of the IOSurface buffer in pixels.
    
    Required for planar IOSurfaces.
*/
extern __gshared const CFStringRef kIOSurfaceHeight;

/**
    CFNumber for the bytes per row of the buffer.

    If not specified, IOSurface will first calculate the number full elements required 
    on each row (by rounding up), multiplied by the bytes per element for this buffer.
    That value will then be appropriately aligned.
*/
extern __gshared const CFStringRef kIOSurfaceBytesPerRow;

/**
    CFNumber for the total number of bytes in an element.
    
    Defaults to 1.
*/
extern __gshared const CFStringRef kIOSurfaceBytesPerElement;

/**
    CFNumber for how many pixels wide each element is.

    Defaults to 1.
*/
extern __gshared const CFStringRef kIOSurfaceElementWidth;

/**
    CFNumber for how many pixels high each element is.

    Defaults to 1.
*/
extern __gshared const CFStringRef kIOSurfaceElementHeight;

/**
    CFNumber for the starting offset into the buffer.
    
    Defaults to 0.
*/
extern __gshared const CFStringRef kIOSurfaceOffset;

/**
    CFArray describing each image plane in the buffer as a CFDictionary.
    
    The CFArray must have at least one entry.
*/
extern __gshared const CFStringRef kIOSurfacePlaneInfo;

/**
    CFNumber for the width of this plane in pixels.
    
    Required for image planes.
*/
extern __gshared const CFStringRef kIOSurfacePlaneWidth;

/**
    CFNumber for the height of this plane in pixels.
    
    Required for image planes.
*/
extern __gshared const CFStringRef kIOSurfacePlaneHeight;

/**
    CFNumber for the bytes per row of this plane.
    
    If not specified, IOSurface will first calculate the number full elements required on 
    each row (by rounding up), multiplied by the bytes per element for this plane.
    That value will then be appropriately aligned. 
*/
extern __gshared const CFStringRef kIOSurfacePlaneBytesPerRow;

/**
    CFNumber for the offset into the buffer for this plane.
    
    If not specified then IOSurface will lay out each plane sequentially based on 
    the previous plane's allocation size.
*/
extern __gshared const CFStringRef kIOSurfacePlaneOffset;

/**
    CFNumber for the total data size of this plane.
    
    Defaults to plane height * plane bytes per row if not specified.
*/
extern __gshared const CFStringRef kIOSurfacePlaneSize;

/**
    CFNumber for the base offset into the buffer for this plane.
    
    Optional, defaults to the plane offset.
*/
extern __gshared const CFStringRef kIOSurfacePlaneBase;

/**
    CFNumber for the bytes per element of this plane.
    
    Optional, defaults to 1. 
*/
extern __gshared const CFStringRef kIOSurfacePlaneBytesPerElement;

/**
    CFNumber for the element width of this plane.
    
    Optional, defaults to 1.
*/
extern __gshared const CFStringRef kIOSurfacePlaneElementWidth;

/**
    CFNumber for the element height of this plane.
    
    Optional, defaults to 1. 
*/
extern __gshared const CFStringRef kIOSurfacePlaneElementHeight;

/**
    CFNumber for the CPU cache mode to be used for the allocation.
    
    Defaults to kIOMapDefaultCache. 
*/
extern __gshared const CFStringRef kIOSurfaceCacheMode;

/**
    If true, the IOSurface may be looked up by any task in the system by its ID.
*/
extern __gshared const CFStringRef kIOSurfaceIsGlobal;

/**
    A 32-bit unsigned integer that stores the traditional Mac OS X buffer format
*/
extern __gshared const CFStringRef kIOSurfacePixelFormat;


//
//      FUNCTIONS
//

/**
    Gets the IOSurface's CoreFoundation type ID
*/
CFTypeID IOSurfaceGetTypeID();

/**
    Increments the per-process usage count for an IOSurface.
*/
void IOSurfaceIncrementUseCount(IOSurfaceRef buffer);

/**
    Decrements the per-process usage count for an IOSurface.
*/
void IOSurfaceDecrementUseCount(IOSurfaceRef buffer);

/**
    Returns the per-process usage count for an IOSurface.
*/
uint IOSurfaceGetUseCount(IOSurfaceRef buffer);

/**
    Returns the smallest aligned value greater than or equal to the specified value.
*/
extern int IOSurfaceAlignProperty(CFStringRef property, int value);

/**
    Gets whether the surface allows casting the size of pixels.
*/
extern bool IOSurfaceAllowsPixelSizeCasting(IOSurfaceRef buffer);

/**
    Retrieves the dictionary associated with the buffer.
*/
extern CFDictionaryRef IOSurfaceCopyAllValues(IOSurfaceRef buffer);

/**
    Retrieves a value from the dictionary associated with the buffer.
*/
extern void* IOSurfaceCopyValue(IOSurfaceRef buffer, CFStringRef key);

/**
    Creates a new IOSurface object
*/
extern IOSurfaceRef IOSurfaceCreate(CFDictionaryRef properties);

/**
    Returns a mach_port_t that holds a reference to the IOSurface.
*/
extern mach_port_t IOSurfaceCreateMachPort(IOSurfaceRef buffer);

/**
    Returns the total allocation size of the buffer including all planes.
*/
size_t IOSurfaceGetAllocSize(IOSurfaceRef buffer);

/**
    Returns the address of the first byte of data in a particular buffer.
*/
void* IOSurfaceGetBaseAddress(IOSurfaceRef buffer);

/**
    Returns the address of the first byte of data in the specified plane.

    If the planeIndex is greater than or equal to the plane count of the IOSurface, zero is returned…. 
    with one exception. If this IOSurface has zero planes and a planeIndex of zero is passed in, 
    the routines function just like the non-planar APIs. 
    
    This is to allow higher level code to treat planar and non-planar buffers is a more uniform fashion.
*/
void* IOSurfaceGetBaseAddressOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Gets the bit depth of the component in the specified plane
*/
size_t IOSurfaceGetBitDepthOfComponentOfPlane(IOSurfaceRef buffer, size_t plane, size_t component);

/**
    Gets the bit offset of the component in the specified plane
*/
size_t IOSurfaceGetBitOffsetOfComponentOfPlane(IOSurfaceRef buffer, size_t plane, size_t component);

/**
    Returns the length (in bytes) of each element in a particular buffer.    
*/
size_t IOSurfaceGetBytesPerElement(IOSurfaceRef buffer);

/**
    Returns the size of each element (in bytes) in the specified plane.
*/
size_t IOSurfaceGetBytesPerElementOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns the length (in bytes) of each row in a particular buffer.
*/
size_t IOSurfaceGetBytesPerRow(IOSurfaceRef buffer);

/**
    Returns the size of each row (in bytes) in the specified plane.
*/
size_t IOSurfaceGetBytesPerRowOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns the height (in pixels) of each element in a particular buffer.
*/
size_t IOSurfaceGetElementHeight(IOSurfaceRef buffer);

/**
    Returns the height (in pixels) of each element in the specified plane.
*/
size_t IOSurfaceGetElementHeightOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns the width (in pixels) of each element in a particular buffer.
*/
size_t IOSurfaceGetElementWidth(IOSurfaceRef buffer);

/**
    Returns the width (in pixels) of each element in the specified plane.
*/
size_t IOSurfaceGetElementWidthOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns the height of the IOSurface buffer in pixels.
*/
size_t IOSurfaceGetHeight(IOSurfaceRef buffer);

/**
    Returns the height of the specified plane (in pixels).
*/
size_t IOSurfaceGetHeightOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Retrieves the unique IOSurfaceID value for an IOSurface.
*/
IOSurfaceID IOSurfaceGetID(IOSurfaceRef buffer);

/**
    Gets the name of a component in the specified plane.
*/
IOSurfaceComponentName IOSurfaceGetNameOfComponentOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Gets the number of components in the specified plane.
*/
size_t IOSurfaceGetNumberOfComponentsOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns an unsigned integer that contains the traditional macOS buffer format.
*/
OSType IOSurfaceGetPixelFormat(IOSurfaceRef buffer);

/**
    Return the number of planes in this buffer. May be 0. 
    Returns 0 for an invalid or NULL buffer pointer.
*/
size_t IOSurfaceGetPlaneCount(IOSurfaceRef buffer);

/**
    Returns the alignment requirements for a property (if any).
*/
size_t IOSurfaceGetPropertyAlignment(CFStringRef property);

/**
    Returns the maximum value for a given property that is guaranteed to 
    be compatible with all of the current devices (GPUs, etc.) in the system.
*/
size_t IOSurfaceGetPropertyMaximum(CFStringRef property);

/**
    Gets the color range for the specified component in the specified plane.
*/
IOSurfaceComponentRange IOSurfaceGetRangeOfComponentOfPlane(IOSurfaceRef buffer, size_t plane, size_t component);

/**
    This will return the current seed value of the buffer and is a cheap call to 
    make to see if the contents of the buffer have changed since the last lock/unlock.
*/
uint IOSurfaceGetSeed(IOSurfaceRef buffer);

/**
    Gets the subsampling information for a IOSurface.
*/
IOSurfaceSubsampling IOSurfaceGetSubsampling(IOSurfaceRef buffer);

/**
    Gets the type of the specified component in the specified plane.
*/
IOSurfaceComponentType IOSurfaceGetTypeOfComponentOfPlane(IOSurfaceRef buffer, size_t plane, size_t component);

/**
    Returns the width of the IOSurface buffer in pixels.
*/
size_t IOSurfaceGetWidth(IOSurfaceRef buffer);

/**
    Returns the width of the specified plane (in pixels).
*/
size_t IOSurfaceGetWidthOfPlane(IOSurfaceRef buffer, size_t plane);

/**
    Returns true of an IOSurface is in use by any 
    process in the system, otherwise false.
*/
bool IOSurfaceGetUseCount(IOSurfaceRef buffer);

/**
    “Lock” an IOSurface for reading or writing.
*/
kern_return_t IOSurfaceLock(IOSurfaceRef buffer, IOSurfaceLockOptions options, uint* seed);

/**
    Performs an atomic lookup and retain of an IOSurface by its IOSurfaceID.
*/
IOSurfaceRef IOSurfaceLookup(IOSurfaceID csid);

/**
    Recreates an IOSurfaceRef from a mach port.
*/
IOSurfaceRef IOSurfaceLookupFromMachPort(mach_port_t port);

/**
    Deletes all values in the dictionary associated with the buffer.
*/
void IOSurfaceRemoveAllValues(IOSurfaceRef buffer);

/**
    Deletes a value in the dictionary associated with the buffer.
*/
void IOSurfaceRemoveValue(IOSurfaceRef buffer, CFStringRef key);

/**
    Sets the values in the dictionary associated with the buffer
    to the values in the provided dictionary.
*/
void IOSurfaceSetValues(IOSurfaceRef buffer, CFDictionaryRef keysAndValues);

/**
    “Unlock” an IOSurface for reading or writing.
*/
kern_return_t IOSurfaceUnlock(IOSurfaceRef buffer, IOSurfaceLockOptions options, uint* seed);