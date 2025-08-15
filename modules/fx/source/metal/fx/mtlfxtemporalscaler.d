/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Bindings to Apple's MetalFX API.
*/
module metalfx.mtlfxtemporalscaler;
import coregraphics.cggeometry;
import foundation;
import metal.device;
import metal.texture;
import metal.commandbuffer;
import metal.sync;
import metal;
import metalfx;
import objc;

import core.attribute : selector, optional;

version(MetalFX):

/**
    A set of properties that configure a temporal scaling effect, and a factory method that 
    creates the effect.
*/
extern(Objective-C)
extern class MTLFXTemporalScalerDescriptor : NSObject {
nothrow @nogc:
public:

    /**
        Returns a Boolean value that indicates whether the temporal scaler works with a GPU.
    */
    static bool supportsDevice(MTLDevice device) @selector("supportsDevice:");

    /**
        Returns the smallest temporal scaling factor the device supports as a floating-point value.
    */
    static float supportedMinScaleFor(MTLDevice device) @selector("supportedInputContentMinScaleForDevice:");

    /**
        Returns the largest temporal scaling factor the device supports as a floating-point value.
    */
    static bool supportedMaxScaleFor(MTLDevice device) @selector("supportedInputContentMaxScaleForDevice:");

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
        A Boolean value that indicates whether the temporal scaler you create with this descriptor uses dynamic resolution.
    */
    @property bool usesDynamicResolution() @selector("isInputContentPropertiesEnabled");
    @property void usesDynamicResolution(bool) @selector("setInputContentPropertiesEnabled:");

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property float inputMinScale() @selector("inputContentMinScale");
    @property void inputMinScale(float) @selector("setInputContentMinScale:");

    /**
        The height of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property float inputMaxScale() @selector("inputContentMaxScale");
    @property void inputMaxScale(float) @selector("setInputContentMaxScale:");

    /**
        The pixel format of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat colorTextureFormat() @selector("colorTextureFormat");
    @property void colorTextureFormat(MTLPixelFormat) @selector("setColorTextureFormat:");

    /**
        The pixel format of the input depth texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat depthTextureFormat() @selector("depthTextureFormat");
    @property void depthTextureFormat(MTLPixelFormat) @selector("setDepthTextureFormat:");

    /**
        The pixel format of the input motion texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat motionTextureFormat() @selector("motionTextureFormat");
    @property void motionTextureFormat(MTLPixelFormat) @selector("setMotionTextureFormat:");

    /**
        A Boolean value that indicates whether MetalFX calculates the exposure for each frame.
    */
    @property bool isAutoExposureEnabled() @selector("isAutoExposureEnabled");
    @property void isAutoExposureEnabled(bool) @selector("setAutoExposureEnabled:");

    /**
        A Boolean value that indicates whether MetalFX compiles a temporal scaling effect’s 
        underlying upscaler as it creates the instance.
    */
    @property bool requiresSynchronousInitialization() @selector("requiresSynchronousInitialization");
    @property void requiresSynchronousInitialization(bool) @selector("setRequiresSynchronousInitialization:");

    /**
        A Boolean value that indicates whether a temporal scaler you create with the 
        descriptor applies a reactive mask.
    */
    @property bool isReactiveMaskTextureEnabled() @selector("isReactiveMaskTextureEnabled");
    @property void isReactiveMaskTextureEnabled(bool) @selector("setReactiveMaskTextureEnabled:");

    /**
        The pixel format of the reactive mask input texture for a temporal scaler you 
        create with the descriptor.
    */
    @property MTLPixelFormat reactiveMaskTextureFormat() @selector("reactiveMaskTextureFormat");
    @property void reactiveMaskTextureFormat(MTLPixelFormat) @selector("setReactiveMaskTextureFormat:");

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
        Creates a temporal scaler instance from this descriptor’s current property values.
    */
    MTLFXTemporalScaler createScalerFor(MTLDevice) @selector("newTemporalScalerWithDevice:");
}

/**
    An upscaling effect that generates a higher resolution texture in a render pass by analyzing 
    multiple input textures over time.
*/
extern(Objective-C)
extern interface MTLFXTemporalScaler : NSObjectProtocol {

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputWidth() const @selector("inputWidth");

    /**
        The height of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property NSUInteger inputHeight() const @selector("inputHeight");

    /**
        The width of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property float inputMinScale() const @selector("inputContentMinScale");

    /**
        The height of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property float inputMaxScale() const @selector("inputContentMaxScale");

    /**
        The pixel format of the input color texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat colorTextureFormat() const @selector("colorTextureFormat");

    /**
        The pixel format of the input depth texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat depthTextureFormat() const @selector("depthTextureFormat");

    /**
        The pixel format of the input motion texture for the temporal scaler you create with this descriptor.
    */
    @property MTLPixelFormat motionTextureFormat() const @selector("motionTextureFormat");

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