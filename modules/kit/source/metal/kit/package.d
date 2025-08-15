/*
    Copyright © 2024, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/

/**
    Bindings to Apple's MetalKit API.
*/
module metalkit;

version(MetalKit):
mixin LinkFramework!("MetalKit");

