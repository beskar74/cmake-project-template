add_executable(hello hello.cpp)
target_link_libraries(hello PRIVATE
        debug boost_debug
        optimized boost_release
        general beskar::lib)
