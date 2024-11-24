/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTLDrawable
*/
module metal.mtldrawable;
import foundation;
import metal;
import objc;

import core.attribute : selector, optional;

/**
    A block of code invoked after a drawable is presented.
*/
alias MTLDrawablePresentedHandler = Block!(void, MTLDrawable);

/**
    A displayable resource that can be rendered or written to. 

    Objects that implement this protocol are connected both to the Metal framework and an underlying 
    display system (such as Core Animation) that’s capable of showing content onscreen. 
    
    You use drawable objects when you want to render images using Metal and present them onscreen.

    Don’t implement this protocol yourself; instead, see CAMetalLayer, 
    for a class that can create and manage drawable objects for you.
*/
extern(Objective-C)
extern interface MTLDrawable : NSObjectProtocol {
nothrow @nogc:
public:

    /**
        A positive integer that identifies the drawable.
    */
    @property NSUInteger drawableID() const;

    /**
        The host time, in seconds, when the drawable was displayed onscreen.

        Typically, you query this property in a callback method. See addPresentedHandler.

        The property value is 0.0 if the drawable hasn’t been presented 
        or if its associated frame was dropped.
    */
    @property CFTimeInterval presentedTime() const;

    /**
        Presents the drawable onscreen as soon as possible.
    */
    void present() @selector("present");

    /**
        Presents the drawable onscreen as soon as possible after a previous 
        drawable is visible for the specified duration.
    */
    void present(CFTimeInterval waitDuration) @selector("presentAfterMinimumDuration:");

    /**
        Presents the drawable onscreen at a specific host time.
    */
    void presentAt(CFTimeInterval time) @selector("presentAtTime:");

    /**
        Registers a block of code to be called immediately after the drawable is presented.

        You can register multiple handlers for a single drawable object.

        The following example code schedules a presentation handler 
        that reads the presentedTime property and uses it to derive the 
        interval between the last and current presentation times. From that information, 
        it determines the app’s frame rate.

        ```d
        // Class property
        CFTimeInterval previousPresentedTime;

        /+ ... +/
        // Render loop
        view.currentDrawable.addPresentedHandler(block((Id!MTLDrawable drawId) {
            
            // Ensure drawable is valid.
            if (auto drawable = drawId.get()) {
                auto presentationDuration = drawable.presentedTime - previousPresentedTime;
                auto framerate = 1.0/presentationDuration;

                /+ ... +/
                previousPresentedTime = drawable.presentedTime;
            }
        }));
        ```
    */
    void addPresentedHandler(MTLDrawablePresentedHandler block) @selector("addPresentedHandler:");
}

version(CoreAnimation):

import coreanimation;

/**
    A Metal drawable associated with a Core Animation layer.
*/
extern(Objective-C)
extern interface CAMetalDrawable : MTLDrawable {
nothrow @nogc:
public:

    /**
        A Metal texture object that contains the drawable’s contents.
    */
    @property MTLTexture texture() const @selector("texture");

    /**
        A Metal texture object that contains the drawable’s contents.
    */
    @property CAMetalLayer layer() const @selector("layer");
}

/**
    A Core Animation layer that Metal can render into, typically displayed onscreen.
*/
extern(Objective-C)
extern class CAMetalLayer : CALayer {
nothrow @nogc:
public:

    /**
        The Metal device responsible for the layer’s drawable resources.
    */
    @property MTLDevice device() @selector("device");
    @property void device(MTLDevice) @selector("setDevice:");

    /**
        The device object that the system recommends using for this layer.
    */
    @property MTLDevice preferredDevice() const @selector("preferredDevice");

    /**
        The pixel format of the layer’s textures.
    */
    @property MTLPixelFormat pixelFormat() @selector("pixelFormat");
    @property void pixelFormat(MTLPixelFormat) @selector("setPixelFormat:");

    /**
        A Boolean value that determines whether the layer’s 
        textures are used only for rendering.
    */
    @property bool framebufferOnly() @selector("framebufferOnly");
    @property void framebufferOnly(bool) @selector("setFramebufferOnly:");

    /**
        The size, in pixels, of textures for rendering layer content.
    */
    @property CGSize drawableSize() @selector("drawableSize");
    @property void drawableSize(CGSize) @selector("setDrawableSize:");

    /**
        A Boolean value that determines whether the layer synchronizes 
        its updates to the display’s refresh rate.
    */
    @property bool displaySyncEnabled() @selector("displaySyncEnabled");
    @property void displaySyncEnabled(bool) @selector("setDisplaySyncEnabled:");

    /**
        Enables extended dynamic range values onscreen.
    */
    @property bool wantsExtendedDynamicRangeContent() @selector("wantsExtendedDynamicRangeContent");
    @property void wantsExtendedDynamicRangeContent(bool) @selector("setWantsExtendedDynamicRangeContent:");

    /**
        The number of Metal drawables in the resource pool 
        managed by Core Animation.
    */
    @property NSUInteger maximumDrawableCount() @selector("maximumDrawableCount");
    @property void wantsExtendedDynamicRangeContent(NSUInteger) @selector("setMaximumDrawableCount:");

    /**
        A Boolean value that determines whether requests for a new 
        buffer expire if the system can’t satisfy them.
    */
    @property bool allowsNextDrawableTimeout() @selector("allowsNextDrawableTimeout");
    @property void allowsNextDrawableTimeout(bool) @selector("setAllowsNextDrawableTimeout:");

    /**
        Waits until a Metal drawable is available, and then returns it.
    */
    CAMetalDrawable next() @selector("nextDrawable");
}