add_executable(main main.cpp)
target_link_libraries(main PRIVATE
        debug boost_debug
        optimized boost_release
        general beskar::lib)

# Setup test binary.
file(GLOB_RECURSE TEST_SOURCES CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/*.test.cpp")
add_executable(test ${TEST_SOURCES})
target_link_libraries(test PUBLIC
        debug google_test_debug
        debug boost_debug
        optimized google_test_release
        optimized boost_release
        general beskar::lib)
