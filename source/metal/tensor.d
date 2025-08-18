/**
    MTLTensor

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.tensor;
import metal.datatype;
import metal.types;
import metal.resource;
import objc.basetypes;

/**
    The possible data types for the elements of a tensor.
*/
enum MTLTensorDataType : NSInteger {
    MTLTensorDataTypeNone     = MTLDataType.None,
    MTLTensorDataTypeFloat32  = MTLDataType.Float,
    MTLTensorDataTypeFloat16  = MTLDataType.Half,
    MTLTensorDataTypeBFloat16 = MTLDataType.BFloat,
    MTLTensorDataTypeInt8     = MTLDataType.Char,
    MTLTensorDataTypeUInt8    = MTLDataType.UChar,
    MTLTensorDataTypeInt16    = MTLDataType.Short,
    MTLTensorDataTypeUInt16   = MTLDataType.UShort,
    MTLTensorDataTypeInt32    = MTLDataType.Int,
    MTLTensorDataTypeUInt32   = MTLDataType.UInt,
}

/// The largest rank a tensor can have.
enum MTL_TENSOR_MAX_RANK = 16;

version(Metal4)
extern(Objective-C)
extern class MTLTensorExtents : NSObject {
@nogc nothrow:
public:

    // alloc
    static override MTLTensorExtents alloc();

    /**
        Creates a new tensor extents with the rank and extent values you provide.

        Params:
            rank =      The number of dimensions.
            values =    An array of length rank that specifies the size of each dimension.
                        The first dimension is the innermost dimension.

        Returns:
            Tensor extents with the rank and extent values you provide.
            Returns $(D null) if rank exceeds 0 and values is $(D null) or 
            if rank exceeds $(D MTL_TENSOR_MAX_RANK).
    */
    MTLTensorExtents initWithRank(NSUInteger rank, const(NSInteger)* values) @selector("initWithRank:values:");

    /**
        Creates a new tensor extents with the rank and extent values you provide.

        Params:
            values = The lengths of each dimension in the extents.

        Returns:
            Tensor extents with the rank and extent values you provide.
            Returns $(D null) if lengths exceeds $(D MTL_TENSOR_MAX_RANK).
    */
    extern(D) static
    MTLTensorExtents create(NSInteger[] lengths) {
        return this.alloc().initWithRank(cast(NSInteger)lengths.length, lengths.ptr);
    }

    /**
        The rank of the tensor.
    */
    @property NSUInteger rank();

    /**
        Returns the extent at an index.

        Params:
            index = The index of the dimension. 
                    The first dimension is the innermost dimension.

        Returns:
            The extent at $(D index), or -1 if $(D index) is 
            greater than or equal to rank.
    */
    NSInteger extentAt(NSUInteger index) @selector("extentAtDimensionIndex:");
}
