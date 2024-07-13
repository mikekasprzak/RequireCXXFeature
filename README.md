# RequireCXXFeature
A set of cmake modules for specifing required C++ and C++ standard library features. It works by checking for
C++20 feature test macros. It builds on the built-in `CheckCXXSymbolExists` cmake module by providing a simpler syntax.

## Usage
Add the `.cmake` files to your project, then include and use them.

### CMakeFiles.txt
```cmake
...

include (RequireCXXFeature.cmake)
# Reference: https://isocpp.org/std/standing-documents/sd-6-sg10-feature-test-recommendations#table-of-feature-test-macros

# Required C++ features
require_cxx_feature(__cpp_constexpr)
require_cxx_feature(__cpp_decltype_auto)
require_cxx_feature(__cpp_lib_coroutine)
require_cxx_feature(__cpp_lib_format)

```

## Polyfilling a C++ feature with CheckCXXFeature
Instead of raising an error, `CheckCXXFeature` sets a variable if the requested C++ feature flag is found.

```cmake
...

include (CheckCXXFeature.cmake)
include (RequireCXXFeature.cmake)
# Reference: https://isocpp.org/std/standing-documents/sd-6-sg10-feature-test-recommendations#table-of-feature-test-macros

# Required C++ features
require_cxx_feature(__cpp_constexpr)
require_cxx_feature(__cpp_decltype_auto)
require_cxx_feature(__cpp_lib_coroutine) 
check_cxx_feature(__cpp_lib_format HAS_LIB_FORMAT)
if (NOT DEFINED "${HAS_LIB_FORMAT}")
  # polyfill config goes here
endif()
```

