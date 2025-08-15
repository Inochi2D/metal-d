/**
    MTLFence

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.fence;
import objc.basetypes;
import foundation;
import metal.device;

import core.attribute : selector, optional;

/**
    A memory fence to capture, track, and manage resource 
    dependencies across command encoders.
*/
extern(Objective-C)
extern interface MTLFence : NSObjectProtocol {
nothrow @nogc:
public:

    /**
        The device this event can be used with.
        Will be $(D null) when the event is shared across devices (i.e. MTLSharedEvent).
    */
    @property MTLDevice device();

    /**
        A string to help identify this object.
    */
    @property NSString label();
    @property void label(NSString value);
}