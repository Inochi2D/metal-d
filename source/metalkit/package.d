/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Bindings to Apple's Metal API.
*/
module metalkit;

static if (IsAppleOS):
version(MetalKit):

mixin LinkFramework!("MetalKit");
