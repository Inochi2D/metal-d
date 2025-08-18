/**
    MTLFunctionDescriptor

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.functiondescriptor;
import metal.functionconstantvalues;
import metal.binaryarchive;
import metal.device;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    Options for a metal function.
*/
enum MTLFunctionOptions : NSUInteger {

    /**
        Default usage.
    */
    None = 0,
    
    /**
        Compiles the found function. This enables dynamic linking of this `MTLFunction`.
        Only supported for `visible` functions.
    */
    CompileToBinary = 1 << 0,

    /**
        Stores and tracks this function in a Metal Pipelines Script
        This flag is optional and only supported in the context of binary archives.
        
        This flag is required for inspecting and consuming binary archives with specialized 
        MTLFunctions via the metal-source tool. 
        It is not required for recompilation, nor for storing functions in binary archives. 
        Set this flag only if you intend to use metal-source on a serialized binary archive.
    */
    StoreFunctionInMetalPipelinesScript = 1 << 1,

    /**
        Function creation fails (i.e nil is returned) if:
            - A lookup binary archive has been specified
            - The function has not been found in the archive
    */
    FailOnBinaryArchiveMiss = 1 << 2,

    /**
        Compiles the function to have its function handles return a constant MTLResourceID across
        all pipeline states. The function needs to be linked to the pipeline that will use this function.
        This function option can only be used for functions that are compiled with `MTLFunctionOptionCompileToBinary`.
     */
    PipelineIndependent = 1 << 3,

}

/**
    A class used to indicate how a function should be created.
*/
extern(Objective-C)
extern class MTLFunctionDescriptor : NSObject, NSCopying {
nothrow @nogc:
public:

    // copyWithZone
    override id copyWithZone(NSZone* zone) @selector("copyWithZone:");

    /**
        Create an autoreleased function descriptor.
    */
    static MTLFunctionDescriptor functionDescriptor();
    
    /**
        The name of the `visible` function to find.
    */
    @property NSString name();
    @property void name(NSString);
    
    /**
        An optional new name for a `visible` function to allow 
        reuse with different specializations.
    */
    @property NSString specializedName();
    @property void specializedName(NSString);
    
    /**
        The set of constant values assigned to the function constants.
        Compilation fails if you do not provide valid constant values 
        for all required function constants.
    */
    @property MTLFunctionConstantValues constantValues();
    @property void constantValues(MTLFunctionConstantValues);
    
    /**
        The options to use for this new `MTLFunction`.
    */
    @property MTLFunctionOptions options();
    @property void options(MTLFunctionOptions);
    
    /**
        The array of archives to be searched.

        Binary archives to be searched for precompiled functions 
        during the compilation of this function.
    */
    @property NSArray!(MTLBinaryArchive) binaryArchives();
    @property void binaryArchives(NSArray!(MTLBinaryArchive));
}

/**
    A class used to indicate how a intersection function should be created.
*/
extern(Objective-C)
extern class MTLIntersectionFunctionDescriptor : NSObject, NSCopying {
nothrow @nogc:
public:

    // copyWithZone
    override id copyWithZone(NSZone* zone) @selector("copyWithZone:");

}