/**
    MTLArgument

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.argument;
import metal.texture;
import metal.commandencoder;
import metal.datatype;
import metal.tensor;
import foundation;
import objc;

enum MTLIndexType : NSUInteger {
    UInt16 = 0,
    UInt32 = 1,
}

/**
    The type of a resource binding.
*/
enum MTLBindingType : NSUInteger {

    /**
        This binding represents a buffer.
    */
    Buffer = 0,

    /**
        This binding represents threadgroup memory.
    */
    ThreadgroupMemory = 1,

    /**
        This binding represents a texture.
    */
    Texture = 2,

    /**
        This binding represents a sampler.
    */
    Sampler = 3,

    /**
        This binding represents an image block data.
    */
    ImageblockData = 16,

    /**
        This binding represents an image block.
    */
    Imageblock = 17,

    /**
        This binding represents a visible function table object.
    */
    VisibleFunctionTable = 24,

    /**
        This binding represents a primitive acceleration structure object.
    */
    PrimitiveAccelerationStructure = 25,

    /**
        This binding represents an instance acceleration structure object.
    */
    InstanceAccelerationStructure = 26,

    /**
        This binding represents an intersection function table object.
    */
    IntersectionFunctionTable = 27,

    /**
        This binding represents an object payload.
    */
    ObjectPayload = 34,

    /**
        This binding represents a tensor object.
    */
    Tensor = 37,
}

/**
    The type for an input to a MTLRenderPipelineState or a MTLComputePipelineState
*/
enum MTLArgumentType : NSUInteger {

    /**
        This input is a MTLBuffer
    */
    Buffer = 0,

    /**
        This input is a pointer to the threadgroup memory.
    */
    ThreadgroupMemory = 1,

    /**
        This input is a MTLTexture.
    */
    Texture = 2,

    /**
        This input is a sampler.
    */
    Sampler = 3,

    MTLArgumentTypeImageblockData = 16,
    MTLArgumentTypeImageblock = 17,
    MTLArgumentTypeVisibleFunctionTable = 24,
    MTLArgumentTypePrimitiveAccelerationStructure = 25,
    MTLArgumentTypeInstanceAccelerationStructure = 26,
    MTLArgumentTypeIntersectionFunctionTable = 27,
}

enum MTLBindingAccess : NSUInteger {
    ReadOnly   = 0,
    ReadWrite  = 1,
    WriteOnly  = 2,
}

/**
    A description of a data type.
*/
extern(Objective-C)
extern class MTLType : NSObject {
@nogc nothrow:
public:

    /**
        The type of the data
    */
    @property MTLDataType dataType();
}

/**
    An object that provides information about a field in a structure.
*/
extern(Objective-C)
extern class MTLStructMember : NSObject {
@nogc nothrow:
public:

    /**
        The name of the struct member.
    */
    @property NSString name();

    /**
        The data type of the struct member.
    */
    @property MTLDataType dataType();

    /**
        The location of this member relative to the start of its struct, in bytes.
    */
    @property NSUInteger offset();

    /**
        The index in the argument table that corresponds to the struct member.
    */
    @property NSUInteger argumentIndex();

    /**
        Provides a description of the underlying struct when the 
        struct member holds a struct.

        Returns:
            An object that describes the member if it is a struct,
            $(D null) otherwise.
    */
    MTLStructType structType();

    /**
        Provides a description of the underlying array when the 
        struct member holds an array.

        Returns:
            An object that describes the member if it is a array,
            $(D null) otherwise.
    */
    MTLArrayType arrayType();

    /**
        Provides a description of the underlying pointer when 
        the struct member holds a pointer.

        Returns:
            An object that describes the member if it is a pointer,
            $(D null) otherwise.
    */
    MTLPointerType pointerType();

    /**
        Provides a description of the underlying texture 
        when the struct member holds a texture.

        Returns:
            An object that describes the member if it is a texture,
            $(D null) otherwise.
    */
    MTLTextureReferenceType textureReferenceType();

    /**
        Provides a description of the underlying tensor type when 
        this struct member holds a tensor.
        
        Returns:
            An object that describes the member if it is a tensor,
            $(D null) otherwise.
    */
    version(Metal4)
    MTLTensorReferenceType tensorReferenceType();
}

/**
    A description of a structure.
*/
extern(Objective-C)
extern class MTLStructType : MTLType {
@nogc nothrow:
public:

    /**
        An array of objects that describe the fields in the struct.
    */
    @property NSArray!(MTLStructMember) members();

    /**
        Provides a representation of a struct member.

        Params:
            name = The name of a member in the struct.
        
        Returns:
            An object that represents the named struct member.
            If name does not match a member name, $(D null) is returned.
    */
    MTLStructMember byName(NSString name);
}

/**
    A description of an array.
*/
extern(Objective-C)
extern class MTLArrayType : MTLType {
@nogc nothrow:
public:

    /**
        The data type of the array’s elements.
    */
    @property MTLDataType elementType();

    /**
        The number of elements in the array.
    */
    @property NSUInteger arrayLength();

    /**
        The stride between array elements, in bytes.
    */
    @property NSUInteger stride();

    /**
        The stride, in bytes, between argument indices.
    */
    @property NSUInteger argumentIndexStride();

    /**
        Provides a description of the underlying struct type when 
        an array holds structs as its elements.

        Returns:
            An object that describes the element if it is a struct,
            $(D null) otherwise.
    */
    MTLStructType elementStructType();

    /**
        Provides a description of the underlying type when an array 
        holds other arrays as its elements.

        Returns:
            An object that describes the element if it is an array,
            $(D null) otherwise.
    */
    MTLArrayType elementArrayType();

    /**
        Provides a description of the underlying texture type 
        when an array holds textures as its elements.

        Returns:
            An object that describes the element if it is a texture,
            $(D null) otherwise.
    */
    MTLTextureReferenceType elementTextureReferenceType();

    /**
        Provides a description of the underlying pointer type 
        when an array holds pointers as its elements.

        Returns:
            An object that describes the element if it is a pointer,
            $(D null) otherwise.
    */
    MTLPointerType elementPointerType();

    /**
        Provides a description of the underlying tensor type 
        when this array holds tensors as its elements.

        Returns:
            An object that describes the element if it is a tensor,
            $(D null) otherwise.
    */
    version(Metal4)
    MTLTensorReferenceType elementTensorReferenceType();
}

/**
    A description of a pointer.
*/
extern(Objective-C)
extern class MTLPointerType : MTLType {
@nogc nothrow:
public:

    /**
        The data type of the element data.
    */
    @property MTLDataType elementType();

    /**
        The function’s read/write access to the element data.
    */
    @property MTLBindingAccess access();

    /**
        The required byte alignment in memory for the element data.
    */
    @property NSUInteger alignment();

    /**
        The size, in bytes, of the element data.
    */
    @property NSUInteger dataSize();

    /**
        Whether the element is an argument buffer.
    */
    @property bool elementIsArgumentBuffer();

    /**
        Provides a description of the underlying struct 
        when the pointer points to a struct.

        Returns:
            An object that describes the pointer if it is a struct,
            $(D null) otherwise.
    */
    MTLStructType elementStructType();

    /**
        Provides a description of the underlying array 
        when the pointer points to an array.

        Returns:
            An object that describes the pointer if it is an array,
            $(D null) otherwise.
    */
    MTLArrayType elementArrayType();
}

/**
    A description of a texture reference.
*/
extern(Objective-C)
extern class MTLTextureReferenceType : MTLType {
@nogc nothrow:
public:

    /**
        The data type of the texture.
    */
    @property MTLDataType textureDataType();

    /**
        The texture type of the texture.
    */
    @property MTLTextureType textureType();

    /**
        The texture’s read/write access to the argument.
    */
    @property MTLBindingAccess access();

    /**
        Whether the texture is a depth texture.
    */
    @property bool isDepthTexture();
}

/**
    An object that represents a tensor in the 
    shading language in a struct or array.
*/
version(Metal4)
extern(Objective-C)
extern class MTLTensorReferenceType : MTLType {
@nogc nothrow:
public:

    /**
        The underlying data format of the tensor.
    */
    @property MTLTensorDataType tensorDataType();

    /**
        The data format you use for indexing into the tensor.
    */
    @property MTLDataType indexType();

    /**
        The array of sizes, in elements, one for each 
        dimension of this tensor.
    */
    @property MTLTensorExtents dimensions();

    /**
        A value that represents the read/write permissions 
        of the tensor.
    */
    @property MTLBindingAccess access();

}

/**
    A binding to a resource in a shader.
*/
extern(Objective-C)
extern interface MTLBinding : NSObjectProtocol {
@nogc nothrow:
public:

    /**
        Name of the binding.
    */
    @property NSString name();

    /**
        Type of the binding.
    */
    @property MTLBindingType type();

    /**
        The binding's read/write access.
    */
    @property MTLBindingAccess access();

    /**
        Index of the binding.
    */
    @property NSUInteger index();

    /**
        Whether the binding is in use.
    */
    @property bool isUsed();

    /**
        Whether the binding is an argument binding.
    */
    @property bool isArgument();
}

/**
    An object that represents a buffer bound to a graphics or 
    compute function.
*/
extern(Objective-C)
extern interface MTLBufferBinding : MTLBinding {
@nogc nothrow:
public:

    /**
        Alignment of the buffer in bytes.
    */
    @property NSUInteger bufferAlignment();

    /**
        Size of the buffer in bytes.
    */
    @property NSUInteger bufferDataSize();

    /**
        Data type of the buffer.
    */
    @property MTLDataType bufferDataType();

    /**
        A description of the underlying buffer when the buffer contains a struct.
    */
    @property MTLStructType bufferStructType();

    /**
        A description of the underlying buffer when the buffer contains pointers.
    */
    @property MTLPointerType bufferPointerType();
}

/**
    An object that represents a thread group bound to a
    compute function.
*/
extern(Objective-C)
extern interface MTLThreadgroupBinding : MTLBinding {
@nogc nothrow:
public:

    /**
        Alignment of the thread group's data, in bytes.
    */
    @property NSUInteger threadgroupMemoryAlignment();

    /**
        Size of the thread group's data, in bytes.
    */
    @property NSUInteger threadgroupMemoryDataSize();
}

/**
    An object that represents a texture bound to a graphics or 
    compute function.
*/
extern(Objective-C)
extern interface MTLTextureBinding : MTLBinding {
@nogc nothrow:
public:

    /**
        The data type of the texture.
    */
    @property MTLDataType textureDataType();

    /**
        The texture type of the texture.
    */
    @property MTLTextureType textureType();

    /**
        Whether the texture is a depth texture.
    */
    @property bool isDepthTexture();

    /**
        The length of the texture array.
    */
    @property NSUInteger arrayLength();
}

/**
    An object that represents an object payload bound to a graphics or 
    compute function.
*/
extern(Objective-C)
extern interface MTLObjectPayloadBinding : MTLBinding {
@nogc nothrow:
public:

    /**
        Minimum alignment of the starting offset in the buffer, in bytes.
    */
    @property NSUInteger objectPayloadAlignment();

    /**
        Size of the object payload data, in bytes.
    */
    @property NSUInteger objectPayloadDataSize();
}

/**
    An object that represents a tensor bound to a graphics or 
    compute function or a machine learning function.
*/
version(Metal4)
extern(Objective-C)
extern interface MTLTensorBinding : MTLBinding {
@nogc nothrow:
public:

    /**
        The underlying data format of this tensor.
    */
    @property MTLTensorDataType tensorDataType();

    /**
        The data format you use for indexing into the tensor.
    */
    @property MTLDataType indexType();

    /**
        The array of sizes, in elements, one for each dimension of this tensor.
    */
    @property MTLTensorExtents dimensions();
}