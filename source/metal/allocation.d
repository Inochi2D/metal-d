/**
    MTLAllocation

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.allocation;
import objc.basetypes;
import foundation;
import metal.device;

import core.attribute : selector, optional;


/**
    Base class for Metal allocations.

    This protocol provides a common interface for adding Metal resources to $(D MTLResidencySet) instances.
    $(D MTLResidencySet.addAllocation) to add a Metal resource allocation to a residency set.
*/
extern(Objective-C)
extern interface MTLAllocation : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        The size of the resource, in bytes.
    */
    @property NSUInteger allocatedSize() const;
}