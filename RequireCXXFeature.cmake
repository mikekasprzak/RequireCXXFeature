# Copyright (c) 2024 Mike Kasprzak
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# https://isocpp.org/std/standing-documents/sd-6-sg10-feature-test-recommendations#table-of-feature-test-macros
# https://en.cppreference.com/w/cpp/feature_test
# https://en.cppreference.com/w/cpp/utility/feature_test

include_guard(GLOBAL)

#include (CheckSymbolExists)
include (CheckCXXSymbolExists)

macro(REQUIRE_CXX_FEATURE SYMBOL)
  if (NOT DEFINED "${SYMBOL}")
    # Feature testing is only available since C++20
    if (NOT CMAKE_CXX_COMPILE_FEATURES MATCHES "cxx_std_20")
      message(FATAL_ERROR "C++20 support is required!\n")
    endif()

    # Header containing the available C++ standard library features
    set(FILES "version")

    #__CHECK_SYMBOL_EXISTS_IMPL(RequireCXXFeature.cxx "${SYMBOL}" "${FILES}" "${SYMBOL}")
    check_cxx_symbol_exists("${SYMBOL}" "${FILES}" "${SYMBOL}")

    # To us, failure is a fatal error
    if (NOT "${${SYMBOL}}")
      # Unset the variable cached by "symbol exists" check
      unset("${SYMBOL}" CACHE)
      message(FATAL_ERROR "Required C++ feature ${SYMBOL} not found!\nSee the feature test documentation, or https://en.cppreference.com/w/cpp/feature_test for details.\n")
    endif()
  endif()
endmacro()
