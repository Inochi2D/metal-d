/**
    MTLLibrary

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.functionconstantvalues;
import metal.datatype;
import metal.argument;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    A list of constant values that can be passed to shaders.
*/
extern(Objective-C)
class MTLFunctionConstantValues : NSObject, NSCopying {
@nogc nothrow:
public:

    // copyWithZone
    override id copyWithZone(NSZone* zone) @selector("copyWithZone:");

    /**
        Sets a constant value.

        Params:
            value = The value to set.
            type =  Type of the value.
            index = Index of the value.
    */
    void setConstantValue(const(void)* value, MTLDataType type, NSUInteger index) @selector("setConstantValue:type:atIndex:");

    /**
        Sets a constant value.

        Params:
            value = The value to set.
            type =  Type of the value.
            name =  Name of the value.
    */
    void setConstantValue(const(void)* value, MTLDataType type, NSString name) @selector("setConstantValue:type:withName:");

    /**
        Sets a range of constant values.

        Params:
            values =    The values to set.
            type =      Type of the values.
            range =     Index range of the values.
    */
    void setConstantValues(const(void)* values, MTLDataType type, NSRange range) @selector("setConstantValues:type:withRange:");

    /**
        Resets the constants, clearing all values.
    */
    void reset();
}