/**
    MTLEvent

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.event;
import objc.basetypes;
import foundation;
import metal.device;

import core.attribute : selector, optional;

/**
    A simple semaphore to synchronize access to Metal resources.
*/
extern(Objective-C)
extern interface MTLEvent : NSObjectProtocol {
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

/**
    A listener for shareable event notifications.
*/
extern(Objective-C)
extern class MTLSharedEventListener : NSObject {
nothrow @nogc:
public:

    override static MTLSharedEventListener alloc();
    override MTLSharedEventListener init();

    /**
        A shared instance constructed with a standard serial dispatch queue.
        This instance can be used for short-running notifications without QoS requirements.
    */
    static MTLSharedEventListener sharedListener();
}

/**
    A block of code invoked after a shareable event’s signal value equals 
    or exceeds a given value.
*/
alias MTLSharedEventNotificationBlock = Block!(void, MTLSharedEvent, ulong);

/**
    An object you use to synchronize access to Metal resources across multiple 
    CPUs, GPUs, and processes.
*/
extern(Objective-C)
extern interface MTLSharedEvent : MTLEvent {
nothrow @nogc:
public:

    /**
        The read-write signal value.
    */
    @property ulong signaledValue();
    @property void signaledValue(ulong value);

    /**
        When the event's signaled value reaches value or higher, 
        invoke the block on the dispatch queue owned by the listener.

        Params:
            listener =  The listener to notify
            value =     The value to use as a gate.
            block =     The clang block to execute.
    */
    void notifyListener(MTLSharedEventListener listener, ulong value, MTLSharedEventNotificationBlock block) @selector("notifyListener:atValue:block:");

    /**
        Convenience method for creating a shared event handle that 
        may be passed to other processes via XPC.

        Returns:
            A new handle that can be shared via XPC.
    */
    MTLSharedEventHandle newSharedEventHandle();

    /**
        Synchronously wait for the signaledValue to be greater than or equal to 'value', 
        with a timeout specified in milliseconds.

        Params:
            value = The value to check for
            timeout = The timeout in miliseconds.
        
        Returns:
            $(D true) if the value was signaled before the timeout, 
            otherwise $(D false).
    */
    bool await(ulong value, ulong timeout) @selector("waitUntilSignaledValue:timeoutMS:");
}

/**
    An object you use to recreate a shareable event.
*/
extern(Objective-C)
extern class MTLSharedEventHandle : NSObject, NSSecureCoding {
nothrow @nogc:
public:
    override void encodeWithCoder(NSCoder coder);
    override @property bool supportsSecureCoding();

    void* _priv;

    /**
        A string to help identify this object.
    */
    @property NSString label();
}