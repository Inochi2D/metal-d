/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Bindings to Apple's MetalFX API.
*/
module metalfx.mtlfxspatialscaler;
import coregraphics.cggeometry;
import foundation;
import metal.mtldevice;
import metal.mtltexture;
import metal.mtlcommandbuffer;
import metal.mtlfence;
import metal;
import metalkit;
import objc;

import core.attribute : selector, optional;

version(MetalFX):

/**
    The color space modes for the input and output textures you use with a 
    spatial scaling effect instance.
*/
enum MTLFXSpatialScalerColorProcessingMode : NSInteger {
    
    /**
        Indicates your input and output textures use a linear color space.
    */
    Linear,
    
    /**
        Indicates your input and output textures use a perceptual color space.
    */
    Perceptual,
    
    /**
        Indicates your input and output textures use a high dynamic range color space.
    */
    HDR
}

/**
    A set of properties that configure a spatial scaling effect, and a factory method that 
    creates the effect.
*/
extern(Objective-C)
extern class MTLFXSpatialScalerDescriptor : NSObject {
nothrow @nogc:
public:

    /**
        Returns a Boolean value that indicates whether the temporal scaler works with a GPU.
    */
    static bool supportsDevice(MTLDevice device) @selector("supportsDevice:");

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputWidth() @selector("inputWidth");
    @property void inputWidth(NSUInteger) @selector("setInputWidth:");

    /**
        The height of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputHeight() @selector("inputHeight");
    @property void inputHeight(NSUInteger) @selector("setInputHeight:");

    /**
        The pixel format of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat colorTextureFormat() @selector("colorTextureFormat");
    @property void colorTextureFormat(MTLPixelFormat) @selector("setColorTextureFormat:");

    /**
        The color space of the input color texture for the spatial scaler you create with this descriptor.
    */
    @property MTLFXSpatialScalerColorProcessingMode colorProcessingMode() @selector("colorProcessingMode");
    @property void colorProcessingMode(MTLFXSpatialScalerColorProcessingMode) @selector("setColorProcessingMode:");
    /**
        The width of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property NSUInteger outputWidth() @selector("outputWidth");
    @property void outputWidth(NSUInteger) @selector("setOutputWidth:");

    /**
        The height of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property NSUInteger outputHeight() @selector("outputHeight");
    @property void outputHeight(NSUInteger) @selector("setOutputHeight:");

    /**
        The pixel format of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property MTLPixelFormat outputTextureFormat() @selector("outputTextureFormat");
    @property void outputTextureFormat(MTLPixelFormat) @selector("setOutputTextureFormat:");

    /**
        Creates a spatial scaler instance from this descriptor’s current property values.
    */
    MTLFXSpatialScaler createScalerFor(MTLDevice) @selector("newSpatialScalerWithDevice:");
}

/**
    An upscaling effect that generates a higher resolution texture in a render pass by spatially 
    analyzing an input texture.
*/
extern(Objective-C)
extern interface MTLFXSpatialScaler : NSObjectProtocol {

    /**
        The minimal texture usage options that your app’s input color texture 
        must set to apply the spatial scaler.
    */
    @property MTLTextureUsage colorTextureUsage() const @selector("colorTextureUsage");

    /**
        An input color texture you set for the spatial scaler that supports the 
        correct color texture usage options.
    */
    @property MTLTexture colorTexture() @selector("colorTexture");
    @property void colorTexture(MTLTexture) @selector("setColorTexture:");

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputContentWidth() @selector("inputContentWidth");
    @property void inputContentWidth(NSUInteger) @selector("setInputContentWidth:");

    /**
        The height, in pixels, of the region within the color texture the spatial scaler uses as its input.
    */
    @property NSUInteger inputContentHeight() @selector("inputContentHeight");
    @property void inputContentHeight(NSUInteger) @selector("setInputContentHeight:");

    /**
        The minimal texture usage options that your app’s output texture 
        must set to apply the spatial scaler.
    */
    @property MTLTextureUsage outputTextureUsage() const @selector("outputTextureUsage");

    /**
        An output texture that supports the correct depth texture usage options.
    */
    @property MTLTexture outputTexture() @selector("outputTexture");
    @property void outputTexture(MTLTexture) @selector("setOutputTexture:");

    /**
        An optional fence instance that you provide to synchronize your app’s untracked resources.
    */
    @property MTLFence fence() @selector("fence");
    @property void fence(MTLFence) @selector("setFence:");

    /**
        Adds the spatial scaler to a render pass’s command buffer.
    */
    void encodeTo(MTLCommandBuffer to) @selector("encodeToCommandBuffer:");

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputWidth() const @selector("inputWidth");

    /**
        The height of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputHeight() const @selector("inputHeight");

    /**
        The pixel format of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat colorTextureFormat() const @selector("colorTextureFormat");

    /**
        The color space of the input color texture for the spatial scaler you create with this descriptor.
    */
    @property MTLFXSpatialScalerColorProcessingMode colorProcessingMode() const @selector("colorProcessingMode");
    /**
        The width of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property NSUInteger outputWidth() const @selector("outputWidth");

    /**
        The height of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property NSUInteger outputHeight() const @selector("outputHeight");

    /**
        The pixel format of the output color texture for the temporal scaler you create 
        with this descriptor.
    */
    @property MTLPixelFormat outputTextureFormat() const @selector("outputTextureFormat");
}