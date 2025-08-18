/**
    MTLDynamicLibrary

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.dynamiclibrary;
import metal.device;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;


/**
    A collection of Metal shader functions.
*/
extern(Objective-C)
extern interface MTLDynamicLibrary : NSObjectProtocol {
nothrow @nogc:
public:
    
    /**
        A string that identifies the library.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        The Metal device object that created the library.
    */
    @property MTLDevice device() const;
    
    /**
        The installation name for a dynamic library.
    */
    @property NSString installName() const;
}