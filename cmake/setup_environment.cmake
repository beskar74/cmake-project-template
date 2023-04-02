macro(set_version)
    execute_process(
            COMMAND bash -c "git describe --tags"
            OUTPUT_VARIABLE VERSION)
    string(REGEX REPLACE "\n$" "" VERSION "${VERSION}")
    message("version ${VERSION}")
    add_definitions("-DVERSION=\"${VERSION}\"")
endmacro()

macro(config_compiler)
    message("Configuring compiler...")

    if ("${CMAKE_BUILD_TYPE}" STREQUAL "" OR "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
        message("Building Debug target.")
        set(CMAKE_BUILD_TYPE "Debug")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0 -g")
    elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
        message("Building Release target.")
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON) # enable LTO
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
    else ()
        message(FATAL_ERROR "Invalid build type: ${CMAKE_BUILD_TYPE}.")
    endif ()

    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    # -Wno-c99-extensions not needed for gcc since the extensions are GNU C. It's a clang thing.
    # https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
    add_compile_options(-Wall -Wextra -Wno-c99-extensions -Wno-missing-field-initializers -Werror=format)
endmacro()

include("cmake/libboost.cmake")
include("cmake/libtestbm.cmake")
include("cmake/libhdrhist.cmake")

macro(load_libs)
    message("Loading libs...")

    setup_boost()
    message("Loaded boost")

    setup_google_benchmark()
    message("Loaded google_benchmark")

    setup_google_test()
    message("Loaded google_test")

    setup_hdr_histogram()
    message("Loaded HdrHistogram_c")
endmacro()

macro(setup_environment)
    set_version()
    message("Version: ${VERSION}")

    config_compiler()
    message("Configured compiler. Using ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")

    load_libs()
    message("Loaded libs.")

    message("Environment setup successfully.")
endmacro()

setup_environment()
