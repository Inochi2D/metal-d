/**
    MTLLibrary

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.library;
import metal.device;
import metal.resource;
import metal.argument;
import metal.types;
import metal.functiondescriptor;
import metal;
import foundation;
import objc;

import core.attribute : selector, optional;
import metal.argumentencoder;


/**
    Types of tessellation patches that can be inputs of 
    a post-tessellation vertex function.
*/
enum MTLPatchType : NSUInteger {
    
    /**
        An option that indicates that this isn’t a post-tessellation vertex function.
    */
    None = 0,
    
    /**
        A triangle patch.
    */
    Triangle = 1,
    
    /**
        A quad patch.
    */
    Quad = 2,
}

/**
    An object that represents an attribute of a vertex function.
*/
extern(Objective-C)
extern class MTLVertexAttribute : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLVertexAttribute alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLVertexAttribute init() @selector("init");
    
    /**
        The name of the attribute.
    */
    @property NSString name() const;

    /**
        The index of the attribute, as declared in Metal shader source code.
    */
    @property NSUInteger index() const @selector("attributeIndex");

    /**
        The data type for the attribute, as declared in Metal shader source code.
    */
    @property MTLDataType type() const @selector("attributeType");

    /**
        A Boolean value that indicates whether this vertex attribute is active.
    */
    @property bool active() const @selector("isActive");

    /**
        A Boolean value that indicates whether this vertex 
        attribute represents control point data.
    */
    @property bool isPatchControlPointData() const;

    /**
        A Boolean value that indicates whether this vertex 
        attribute represents patch data.
    */
    @property bool isPatchData() const;
}

/**
    An object that describes an attribute defined in 
    the stage-in argument for a shader.
*/
extern(Objective-C)
extern class MTLAttribute : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLAttribute alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLAttribute init() @selector("init");
    
    /**
        The name of the attribute.
    */
    @property NSString name() const;

    /**
        The index of the attribute, as declared in Metal shader source code.
    */
    @property NSUInteger index() const @selector("attributeIndex");

    /**
        The data type for the attribute, as declared in Metal shader source code.
    */
    @property MTLDataType type() const @selector("attributeType");

    /**
        A Boolean value that indicates whether this vertex attribute is active.
    */
    @property bool active() const @selector("isActive");

    /**
        A Boolean value that indicates whether this vertex 
        attribute represents control point data.
    */
    @property bool isPatchControlPointData() const;

    /**
        A Boolean value that indicates whether this vertex 
        attribute represents patch data.
    */
    @property bool isPatchData() const;
}

/**
    The type of a top-level Metal Shading Language (MSL) function.
*/
enum MTLFunctionType : NSUInteger {
    
    /**
        A vertex function you can use in a render pipeline state object.
    */
    Vertex = 1,
    
    /**
        A fragment function you can use in a render pipeline state object.
    */
    Fragment = 2,
    
    /**
        A kernel you can use in a compute pipeline state object.
    */
    Kernel = 3,
    
    /**
        A function you can use in a visible function table.
    */
    Visible = 5,
    
    /**
        A function you can use in an intersection function table.
    */
    Intersection = 6,
    
    /**
        A mesh function you can use in a render pipeline state object.
    */
    Mesh = 7,
    
    /**
        An object function you can use in a render pipeline state object.
    */
    Object = 8,
}

/**
    A constant that specializes the behavior of a shader.
*/
extern(Objective-C)
extern class MTLFunctionConstant : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLFunctionConstant alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLFunctionConstant init() @selector("init");
    
    /**
        The name of the function constant.
    */
    @property NSString name() const;

    /**
        The data type of the function constant.
    */
    @property MTLDataType type() const;

    /**
        The index of the function constant.
    */
    @property NSUInteger index() const;

    /**
        A Boolean value indicating whether the function constant 
        must be provided to specialize the function.
    */
    @property bool required() const;
}

/**
    An object that represents a public shader function in a Metal library.
*/
extern(Objective-C)
extern interface MTLFunction : NSObjectProtocol {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    static MTLFunction alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    MTLFunction init() @selector("init");
    
    /**
        A string that identifies the shader function.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        The device object that created the shader function.
    */
    @property MTLDevice device() const;
    
    /**
        The function’s name.
    */
    @property NSString name() const;

    /**
        The shader function’s type.
    */
    @property MTLFunctionType functionType() const;

    /**
        The tessellation patch type of a post-tessellation vertex function.
    */
    @property MTLPatchType patchType() const;

    /**
        The number of patch control points in the post-tessellation vertex function.
    */
    @property NSInteger patchControlPointCount() const;

    /**
        An array that describes the vertex input attributes to a vertex function.
    */
    @property NSArray!MTLVertexAttribute vertexAttributes() const;

    /**
        An array that describes the input attributes to the function. 
    */
    @property NSArray!MTLAttribute stageInputAttributes() const;

    /**
        A dictionary of function constants for a specialized function. 
    */
    @property NSDictionary!(NSString, MTLFunctionConstant) functionConstantsDictionary() const;

    /**
        The options that Metal used to compile this function.
    */
    @property MTLFunctionOptions options() const;

    /**
        Creates an argument encoder which will encode arguments matching the 
        layout of the argument buffer at the given bind point index.

        Params:
            bufferIndex = The bind point index to create the encoder for.
    */
    MTLArgumentEncoder newArgumentEncoderWithBufferIndex(NSUInteger bufferIndex);
}

enum MTLLanguageVersion : NSUInteger {
    Version1_0 = 65_536,
    Version1_1 = 65_537,
    Version1_2 = 65_538,
    Version2_0 = 13_1072,
    Version2_1 = 13_1073,
    Version2_2 = 13_1074,
    Version2_3 = 13_1075,
    Version2_4 = 13_1076,
    Version3_0 = 19_6608,
    Version3_1 = 19_6609,
    Version3_2 = 19_6610,
}

enum MTLLibraryType : NSInteger {
    Executable = 0,
    Dynamic = 1,
}

enum MTLLibraryOptimizationLevel : NSInteger {
    Default = 0,
    LevelSize = 1,
}

enum MTLCompileSymbolVisibility : NSInteger {
    Default = 0,
    Hidden = 1,
}

enum MTLMathMode : NSInteger {
    Safe = 0,
    Relaxed = 1,
    Fast = 2,
}

enum MTLMathFloatingPointFunctions : NSInteger {
    Fast = 0,
    Precise = 1,
}
/**
    Compilation settings for a Metal shader library.
*/
extern(Objective-C)
extern class MTLCompileOptions : NSObject {
nothrow @nogc:
public:

    /**
        Returns a new instance of the receiving class.
    */
    override static MTLCompileOptions alloc() @selector("alloc");

    /**
        Implemented by subclasses to initialize a new object (the receiver) 
        immediately after memory for it has been allocated.
    */
    override MTLCompileOptions init() @selector("init");

    /**
        A list of preprocessor macros to apply when compiling the library source.
    */
    @property NSDictionary!(NSString, NSObject) preprocessorMacros() const;
    @property void preprocessorMacros(NSDictionary!(NSString, NSObject) preprocessorMacros);

    /**
        An indication of whether the compiler can perform optimizations for 
        floating-point arithmetic that may violate the IEEE 754 standard.
    */
    @property MTLMathMode mathMode() const;
    @property void mathMode(MTLMathMode mathMode);

    /**
        The FP32 math functions Metal uses.
    */
    @property MTLMathFloatingPointFunctions mathFloatingPointFunctions() const;
    @property void mathFloatingPointFunctions(MTLMathFloatingPointFunctions mathFloatingPointFunctions);

    /**
        The language version for interpreting the library source code.
    */
    @property MTLLanguageVersion languageVersion() const;
    @property void languageVersion(MTLLanguageVersion languageVersion);

    /**
        The kind of library to create.
    */
    @property MTLLibraryType libraryType() const;
    @property void libraryType(MTLLibraryType libraryType);

    /**
        For a dynamic library, the name to use when installing the library.
    */
    @property NSString installName() const;
    @property void installName(NSString installName);

    /**
        An array of dynamic libraries the Metal compiler links against.
    */
    @property NSArray!MTLDynamicLibrary libraries() const;
    @property void libraries(NSArray!MTLDynamicLibrary libraries);

    /**
        A Boolean value that indicates whether the compiler compiles vertex shaders 
        conservatively to generate consistent position calculations.
    */
    @property bool preserveInvariance() const;
    @property void preserveInvariance(bool preserveInvariance);

    /**
        An option that tells the compiler what to prioritize when it compiles 
        Metal shader code.
    */
    @property MTLLibraryOptimizationLevel optimizationLevel() const;
    @property void optimizationLevel(MTLLibraryOptimizationLevel optimizationLevel);

    /**
        Symbol visibility.
    */
    @property MTLCompileSymbolVisibility compileSymbolVisibility() const;
    @property void compileSymbolVisibility(MTLCompileSymbolVisibility compileSymbolVisibility);

    /**
        A Boolean that indeicates whether shaders are allowed to reference 
        undefined symbols.
    */
    @property bool allowReferencingUndefinedSymbols() const;
    @property void allowReferencingUndefinedSymbols(bool allowReferencingUndefinedSymbols);

    /**
        An option that tells the compiler the maximum amount of threads
        that may be assigned to a thread group.
    */
    @property NSUInteger maxTotalThreadsPerThreadgroup() const;
    @property void maxTotalThreadsPerThreadgroup(NSUInteger maxTotalThreadsPerThreadgroup);

    /**
        A Boolean value that enables shader logging.
    */
    @property bool enableLogging() const;
    @property void enableLogging(bool enableLogging);
}

/**
    NSErrors raised when creating a library.
*/
extern(C) extern __gshared const(NSErrorDomain) MTLLibraryErrorDomain;

/**
    NSErrors raised when creating a library.
*/
enum MTLLibraryError : NSUInteger {
    Unsupported = 1,
    Internal = 2,
    CompileFailure = 3,
    CompileWarning = 4,
    FunctionNotFound = 5,
    FileNotFound = 6,
}

/**
    A collection of Metal shader functions.
*/
extern(Objective-C)
extern interface MTLLibrary : NSObjectProtocol {
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
    
    /**
        The library’s basic type.
    */
    @property MTLLibraryType type() const;

    /**
        The names of all public functions in the library.
    */
    @property NSArray!NSString functionNames() const;

    /**
        Creates an object that represents a shader function in the library.

        Params:
            name = The name of the function to create.

        Returns:
            A pointer to a function object, or $(D null) 
            if the function is not found in the library.
    */
    MTLFunction newFunctionWithName(NSString name) @selector("newFunctionWithName:");

    /**
        Creates an object that represents a shader function in the library.

        Params:
            name =      The name of the function to create.
            constants = The constant values to set for the function
            error     = Where to store any potential errors.

        Returns:
            A pointer to a function object, or $(D null) 
            if the function is not found in the library.
    */
    MTLFunction newFunctionWithName(NSString name, MTLFunctionConstantValues constants, ref NSError error) @selector("newFunctionWithName:constantValues:error:");

    /**
        Create a new MTLFunction object synchronously.

        Params:
            descriptor =    A descriptor for the function.
            error =         Where to store any potential errors.

        Returns:
            A pointer to a function object, or $(D null) 
            if the function is not found in the library.
    */
    MTLFunction newFunctionWithDescriptor(MTLFunctionDescriptor descriptor, ref NSError error) @selector("newFunctionWithDescriptor:error:");

    /**
        Create a new MTLFunction object synchronously.

        Params:
            descriptor =    A descriptor for the function.
            error =         Where to store any potential errors.

        Returns:
            A pointer to a function object, or $(D null) 
            if the function is not found in the library.
    */
    MTLFunction newIntersectionFunctionWithDescriptor(MTLIntersectionFunctionDescriptor descriptor, ref NSError error) @selector("newIntersectionFunctionWithDescriptor:error:");
}
