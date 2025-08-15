/**
    MTLVertexDescriptor

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Luna Nielsen
*/
module metal.vertexdescriptor;
import metal.device;
import foundation;
import objc;

import core.attribute : selector, optional;

/**
    Specifies how the vertex attribute data is laid out in memory.
*/
enum MTLVertexFormat : NSUInteger {
    Invalid = 0,
    UChar2 = 1,
    UChar3 = 2,
    UChar4 = 3,
    Char2 = 4,
    Char3 = 5,
    Char4 = 6,
    UChar2Normalized = 7,
    UChar3Normalized = 8,
    UChar4Normalized = 9,
    Char2Normalized = 10,
    Char3Normalized = 11,
    Char4Normalized = 12,
    UShort2 = 13,
    UShort3 = 14,
    UShort4 = 15,
    Short2 = 16,
    Short3 = 17,
    Short4 = 18,
    UShort2Normalized = 19,
    UShort3Normalized = 20,
    UShort4Normalized = 21,
    Short2Normalized = 22,
    Short3Normalized = 23,
    Short4Normalized = 24,
    Half2 = 25,
    Half3 = 26,
    Half4 = 27,
    Float = 28,
    Float2 = 29,
    Float3 = 30,
    Float4 = 31,
    Int = 32,
    Int2 = 33,
    Int3 = 34,
    Int4 = 35,
    UInt = 36,
    UInt2 = 37,
    UInt3 = 38,
    UInt4 = 39,
    Int1010102Normalized = 40,
    UInt1010102Normalized = 41,
    UChar4Normalized_BGRA = 42,
    UChar = 45,
    Char = 46,
    UCharNormalized = 47,
    CharNormalized = 48,
    UShort = 49,
    Short = 50,
    UShortNormalized = 51,
    ShortNormalized = 52,
    Half = 53,
    FloatRG11B10 = 54,
    FloatRGB9E5 = 55,
}

enum MTLVertexStepFunction : NSUInteger {
    Constant = 0,
    PerVertex = 1,
    PerInstance = 2,
    PerPatch = 3,
    PerPatchControlPoint = 4,
}

/**
    When a MTLVertexBufferLayoutDescriptor has its stride set to this value,
    the stride will be dynamic and must be set explicitly when binding a buffer
    to a render command encoder.
*/
enum NSUInteger MTLBufferLayoutStrideDynamic = NSUInteger.max;

extern(Objective-C)
extern class MTLVertexBufferLayoutDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:
    override id copyWithZone(NSZone* zone);

    override static MTLVertexBufferLayoutDescriptor alloc();
    override MTLVertexBufferLayoutDescriptor init();

    @property NSUInteger stride();
    @property void stride(NSUInteger value);

    @property MTLVertexStepFunction stepFunction();
    @property void stepFunction(MTLVertexStepFunction value);

    @property NSUInteger stepRate();
    @property void stepRate(NSUInteger value);
}

extern(Objective-C)
extern class MTLVertexBufferLayoutDescriptorArray : NSObject {
@nogc nothrow:
public:

    MTLVertexBufferLayoutDescriptor get(NSUInteger index) @selector("objectAtIndexedSubscript:");
    void set(MTLVertexBufferLayoutDescriptor desc, NSUInteger index) @selector("setObject:atIndexedSubscript:");
}

extern(Objective-C)
extern class MTLVertexAttributeDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:
    override id copyWithZone(NSZone* zone);

    override static MTLVertexAttributeDescriptor alloc();
    override MTLVertexAttributeDescriptor init();

    @property MTLVertexFormat format();
    @property void format(MTLVertexFormat value);

    @property NSUInteger offset();
    @property void offset(NSUInteger value);

    @property NSUInteger bufferIndex();
    @property void bufferIndex(NSUInteger value);
}

extern(Objective-C)
extern class MTLVertexAttributeDescriptorArray : NSObject {
@nogc nothrow:
public:

    MTLVertexAttributeDescriptor get(NSUInteger index) @selector("objectAtIndexedSubscript:");
    void set(MTLVertexAttributeDescriptor desc, NSUInteger index) @selector("setObject:atIndexedSubscript:");
}

extern(Objective-C)
extern class MTLVertexDescriptor : NSObject, NSCopying {
@nogc nothrow:
public:
    override id copyWithZone(NSZone* zone);

    static MTLVertexDescriptor create() @selector("vertexDescriptor");
    @property MTLVertexBufferLayoutDescriptorArray layouts();
    @property MTLVertexAttributeDescriptorArray attributes();
    void reset();
}