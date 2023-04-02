cmake_minimum_required(VERSION 3.13)

project(beskar
        LANGUAGES CXX
        VERSION 0.1.0)

include("cmake/setup_environment.cmake")

# libraries
add_subdirectory(lib)

# binaries
add_subdirectory(src)
add_subdirectory(examples)
