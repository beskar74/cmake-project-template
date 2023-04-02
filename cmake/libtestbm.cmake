set(LOCAL_TEST_PREFIX "/usr/local" CACHE PATH "Location of google benchmark/test for the local build")
set(LOCAL_TEST_INCLUDE_PREFIX "${LOCAL_TEST_PREFIX}/include" CACHE PATH "Location of google benchmark/test headers")
set(LOCAL_TEST_LIB_PREFIX "${LOCAL_TEST_PREFIX}/lib" CACHE PATH "Location of google benchmark/test libraries")

macro(setup_google_benchmark)
    add_library(google_benchmark_debug STATIC IMPORTED GLOBAL)
    target_include_directories(google_benchmark_debug INTERFACE "${LOCAL_TEST_INCLUDE_PREFIX}")
    set_target_properties(google_benchmark_debug PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_TEST_INCLUDE_PREFIX}"
            IMPORTED_LOCATION "${LOCAL_TEST_LIB_PREFIX}/libbenchmark-debug.a")

    add_library(google_benchmark_release STATIC IMPORTED GLOBAL)
    target_include_directories(google_benchmark_release INTERFACE "${LOCAL_TEST_INCLUDE_PREFIX}")
    set_target_properties(google_benchmark_release PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_TEST_INCLUDE_PREFIX}"
            IMPORTED_LOCATION "${LOCAL_TEST_LIB_PREFIX}/libbenchmark-release.a")
endmacro()

macro(setup_google_test)
    message("google test debug include ${LOCAL_TEST_INCLUDE_PREFIX}")
    message("google test debug libs ${LOCAL_TEST_LIB_PREFIX}")

    add_library(google_test_debug STATIC IMPORTED GLOBAL)
    target_include_directories(google_test_debug INTERFACE "${LOCAL_TEST_INCLUDE_PREFIX}")
    set_target_properties(google_test_debug PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_TEST_INCLUDE_PREFIX}"
            IMPORTED_LOCATION "${LOCAL_TEST_LIB_PREFIX}/libgtest-debug.a")

    add_library(google_test_release STATIC IMPORTED GLOBAL)
    target_include_directories(google_test_release INTERFACE "${LOCAL_TEST_INCLUDE_PREFIX}")
    set_target_properties(google_test_release PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_TEST_INCLUDE_PREFIX}"
            IMPORTED_LOCATION "${LOCAL_TEST_LIB_PREFIX}/libgtest-release.a")
endmacro()

