/**
    MTLBinaryArchive

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.binaryarchive;
import metal.device;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    Error domain for binary archives.
*/
extern(C) extern __gshared const(NSErrorDomain) MTLBinaryArchiveDomain;

/**
    Error codes for binary archives.
*/
enum MTLBinaryArchiveError : NSUInteger {
    None = 0,
    InvalidFile = 1,
    UnexpectedElement = 2,
    CompilationFailure = 3,
    InternalError = 4,
}

/**
    A class used to indicate how an archive should be created
*/
extern(Objective-C)
extern class MTLBinaryArchiveDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:

    /**
        Returns a new instance that’s a copy of the receiver.
    */
    override id copyWithZone(NSZone* zone) @selector("copyWithZone:");
    
    /**
        The file URL from which to open a MTLBinaryArchive, 
        or $(D null) to create an empty MTLBinaryArchive.
    */
    @property NSURL url();
    @property void url(NSURL value);
}

/**
    A container of pipeline state descriptors and their associated compiled code.
*/
extern(Objective-C)
extern interface MTLBinaryArchive : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The device this argument encoder was created against.
    */
    @property MTLDevice device();
    
    /**
        A string to help identify this object.
    */
    @property NSString label();
    @property void label(NSString value);
}