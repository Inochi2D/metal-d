# D Bindings for Metal

This is a package which provides D bindings for the Metal rendering library.
Additionally bindings for MetalKit and IOSurface are provided, 
which can be enabled with the `MetalKit` and `IOSurface` version tags respectively.

## NOTE

This library depends on Objective-D, which likewise depends on a compiler capable of doing
Objective-C codegen. If you're using LDC2 you will need [this](https://github.com/ldc-developers/ldc/pull/4777#issuecomment-2495817688) patch!