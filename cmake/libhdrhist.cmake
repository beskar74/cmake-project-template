set(LOCAL_HDR_HISTOGRAM_PREFIX "/usr/local" CACHE PATH "Location of HdrHistogram_c for the local build")
set(LOCAL_HDR_HISTOGRAM_INCLUDE_PREFIX "${LOCAL_HDR_HISTOGRAM_PREFIX}/include" CACHE PATH "Location of HdrHistogram_c headers")
set(LOCAL_HDR_HISTOGRAM_LIB_PREFIX "${LOCAL_HDR_HISTOGRAM_PREFIX}/lib" CACHE PATH "Location of HdrHistogram_c libraries")

macro(setup_hdr_histogram)
    message("Setting up HdrHistogram_c...")

    add_library(hdr_histogram_debug STATIC IMPORTED GLOBAL)
    target_include_directories(hdr_histogram_debug INTERFACE
        "${LOCAL_HDR_HISTOGRAM_INCLUDE_PREFIX}")
    set_target_properties(hdr_histogram_debug PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_HDR_HISTOGRAM_INCLUDE_PREFIX}"
        IMPORTED_LOCATION "${LOCAL_HDR_HISTOGRAM_LIB_PREFIX}/libhdr_histogram-debug.a")

    add_library(hdr_histogram_release STATIC IMPORTED GLOBAL)
    target_include_directories(hdr_histogram_release INTERFACE
        "${LOCAL_HDR_HISTOGRAM_INCLUDE_PREFIX}")
    set_target_properties(hdr_histogram_release PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_HDR_HISTOGRAM_INCLUDE_PREFIX}"
        IMPORTED_LOCATION "${LOCAL_HDR_HISTOGRAM_LIB_PREFIX}/libhdr_histogram-release.a")
endmacro()
