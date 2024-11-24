/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    MTKView
*/
module metalkit.mtkview;
import coregraphics.cggeometry;
import foundation;
import metalkit;
import objc;

import core.attribute : selector, optional;

version(MetalKit):

// HACK: This is temporary until I get UIKit and AppKit bindings made.
alias UIView = NSObject;
alias NSView = NSObject;

/**
    This super-class which MTKView inherits from which depends on the
    target platform.

    On macOS it is NSView, on all other apple platforms it's UIView.
*/
static if (AppleOS)
    alias MTKViewSuperClass = UIView;
else static if (AppleMobileOS)
    alias MTKViewSuperClass = NSView;
else
    static assert(0, "Non-apple platform!");

/**

*/
extern(Objective-C)
extern class MTKView : MTKViewSuperClass {

}

/**
    Methods for responding to a MetalKit view’s drawing and resizing events.
*/
extern(Objective-C)
extern interface MTKViewDelegate : NSObjectProtocol {

    /**
        Called upon receiving a change in layout, resolution, or size.

        Use this method to recompute any view or projection matrices, 
        or to regenerate any buffers to be compatible with the view’s new size.
    */
    void onSizeChanged(MTKView view, CGSize size) @selector("mtkView:drawableSizeWillChange:");

    /**
        Draws the view’s contents.

        This method is called on the delegate when it is asked to render into the view.
    */
    void onDraw(MTKView view) @selector("drawInMTKView:");
}