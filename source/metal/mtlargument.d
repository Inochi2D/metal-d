/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLArgument
*/
module metal.mtlargument;
import metal.mtltexture;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    The types of GPU functions, including shaders and compute kernels.
*/
enum MTLDataType : NSUInteger {

    /**
        A placeholder that represents a GPU function parameter that doesn’t have a valid data type.
    */
    None = 0,
    Struct = 1,
    Array = 2,
    Float = 3,
    Float2 = 4,
    Float3 = 5,
    Float4 = 6,
    Float2x2 = 7,
    Float2x3 = 8,
    Float2x4 = 9,
    Float3x2 = 10,
    Float3x3 = 11,
    Float3x4 = 12,
    Float4x2 = 13,
    Float4x3 = 14,
    Float4x4 = 15,
    Half = 16,
    Half2 = 17,
    Half3 = 18,
    Half4 = 19,
    Half2x2 = 20,
    Half2x3 = 21,
    Half2x4 = 22,
    Half3x2 = 23,
    Half3x3 = 24,
    Half3x4 = 25,
    Half4x2 = 26,
    Half4x3 = 27,
    Half4x4 = 28,
    Int = 29,
    Int2 = 30,
    Int3 = 31,
    Int4 = 32,
    UInt = 33,
    UInt2 = 34,
    UInt3 = 35,
    UInt4 = 36,
    Short = 37,
    Short2 = 38,
    Short3 = 39,
    Short4 = 40,
    UShort = 41,
    UShort2 = 42,
    UShort3 = 43,
    UShort4 = 44,
    Char = 45,
    Char2 = 46,
    Char3 = 47,
    Char4 = 48,
    UChar = 49,
    UChar2 = 50,
    UChar3 = 51,
    UChar4 = 52,
    Bool = 53,
    Bool2 = 54,
    Bool3 = 55,
    Bool4 = 56,
    Texture = 58,
    Sampler = 59,
    Pointer = 60,
    R8Unorm = 62,
    R8Snorm = 63,
    R16Unorm = 64,
    R16Snorm = 65,
    RG8Unorm = 66,
    RG8Snorm = 67,
    RG16Unorm = 68,
    RG16Snorm = 69,
    RGBA8Unorm = 70,
    RGBA8Unorm_sRGB = 71,
    RGBA8Snorm = 72,
    RGBA16Unorm = 73,
    RGBA16Snorm = 74,
    RGB10A2Unorm = 75,
    RG11B10Float = 76,
    RGB9E5Float = 77,
    RenderPipeline = 78,
    ComputePipeline = 79,
    IndirectCommandBuffer = 80,
    Long = 81,
    Long2 = 82,
    Long3 = 83,
    Long4 = 84,
    ULong = 85,
    ULong2 = 86,
    ULong3 = 87,
    ULong4 = 88,
    VisibleFunctionTable = 115,
    IntersectionFunctionTable = 116,
    PrimitiveAccelerationStructure = 117,
    InstanceAccelerationStructure = 118,
    BFloat = 121,
    BFloat2 = 122,
    BFloat3 = 123,
    BFloat4 = 124,
}

enum MTLBindingType : NSUInteger {
    Buffer = 0,
    ThreadgroupMemory = 1,
    Texture = 2,
    Sampler = 3,
    ImageblockData = 16,
    Imageblock = 17,
    VisibleFunctionTable = 24,
    PrimitiveAccelerationStructure = 25,
    InstanceAccelerationStructure = 26,
    IntersectionFunctionTable = 27,
    ObjectPayload = 34,
}

enum MTLAccess : NSUInteger {
    ReadOnly = 0,
    ReadWrite = 1,
    WriteOnly = 2,
}

/**
    A description of a data type.
*/
extern(Objective-C)
extern class MTLType : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLType alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLType init() @selector("init");

    /**
        The data type of the function argument.
    */
    @property MTLDataType dataType() const @selector("dataType");
}

/**
    An object that provides information about a field in a structure.
*/
extern(Objective-C)
extern class MTLPointerType : MTLType {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLPointerType alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLPointerType init() @selector("init");
    
    /**
        The required byte alignment in memory for the element data.
    */
    @property NSUInteger alignment() const;

    /**
        The data type of the struct member.
    */
    @property NSUInteger dataSize() const;

    /**
        The data type of the element data.
    */
    @property MTLDataType type() const @selector("elementType");

    /**
        The function’s read/write access to the element data.
    */
    @property MTLAccess access() const;

    /**
        A Boolean value that indicates whether the element is an argument buffer.
    */
    @property bool isArgumentBuffer() const @selector("elementIsArgumentBuffer");

    /**
        Provides a description of the underlying array when 
        the pointer points to an array.
    */
    @property MTLArrayType elementArrayType() const;

    /**
        Provides a description of the underlying array when 
        the pointer points to a struct.
    */
    @property MTLStructType elementStructType() const;
}

/**
    A description of a texture.
*/
extern(Objective-C)
extern class MTLTextureReferenceType : MTLType {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLTextureReferenceType alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLTextureReferenceType init() @selector("init");
    
    /**
        The texture type of the texture.
    */
    @property MTLTextureType textureType() const;

    /**
        The data type of the texture.
    */
    @property MTLDataType type() const @selector("textureDataType");

    /**
        The texture's read/write access to the argument.
    */
    @property MTLAccess access() const;

    /**
        A Boolean value that indicates whether the texture is a depth texture.
    */
    @property bool isDepthTexture() const;
}

/**
    An object that provides information about a field in a structure.
*/
extern(Objective-C)
extern class MTLArrayType : MTLType {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLArrayType alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLArrayType init() @selector("init");
    
    /**
        The name of the struct member.
    */
    @property NSString name() const;

    /**
        The data type of the struct member.
    */
    @property MTLDataType type() const @selector("dataType");

    /**
        The location of this member relative to the start of its struct, in bytes.
    */
    @property NSUInteger offset() const;

    /**
        The index in the argument table that corresponds to the struct member.
    */
    @property NSUInteger index() const @selector("argumentIndex");

    /**
        Provides a description of the underlying type when 
        an array holds other arrays as its elements.
    */
    @property MTLArrayType elementArrayType() const;

    /**
        Provides a description of the underlying struct type 
        when an array holds structs as its elements.
    */
    @property MTLStructType elementStructType() const;

    /**
        Provides a description of the underlying pointer type 
        when an array holds pointers as its elements.
    */
    @property MTLPointerType elementPointerType() const;

    /**
        Provides a description of the underlying texture type 
        when an array holds textures as its elements.
    */
    @property MTLTextureReferenceType elementTextureReferenceType() const;
}

/**
    An object that provides information about a field in a structure.
*/
extern(Objective-C)
extern class MTLStructMember : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLStructMember alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLStructMember init() @selector("init");
    
    /**
        The name of the struct member.
    */
    @property NSString name() const;

    /**
        The data type of the struct member.
    */
    @property MTLDataType type() const @selector("dataType");

    /**
        The location of this member relative to the start of its struct, in bytes.
    */
    @property NSUInteger offset() const;

    /**
        The index in the argument table that corresponds to the struct member.
    */
    @property NSUInteger index() const @selector("argumentIndex");

    /**
        Provides a description of the underlying array when 
        the struct member holds an array.
    */
    @property MTLArrayType arrayType() const;

    /**
        Provides a description of the underlying struct when 
        the struct member holds a struct.
    */
    @property MTLStructType structType() const;

    /**
        Provides a description of the underlying pointer when 
        the struct member holds a pointer.
    */
    @property MTLPointerType pointerType() const;

    /**
        Provides a description of the underlying texture when 
        the struct member holds a texture.
    */
    @property MTLTextureReferenceType textureReferenceType() const;
}

/**
    A description of a structure.
*/
extern(Objective-C)
extern class MTLStructType : MTLType {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLStructType alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLStructType init() @selector("init");
    
    /**
        An array of objects that describe the fields in the struct.
    */
    @property NSArray!MTLStructMember members() const;

    /**
        The data type of the struct member.
    */
    @property MTLDataType type() const @selector("dataType");

    /**
        Provides a representation of a struct member.
    */
    @property MTLStructMember get(NSString name) @selector("memberByName:");
}