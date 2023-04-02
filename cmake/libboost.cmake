set(LOCAL_BOOST_PREFIX "/usr/local" CACHE PATH "Location of boost for the local build")
set(LOCAL_BOOST_INCLUDE_PREFIX "${LOCAL_BOOST_PREFIX}/include" CACHE PATH "Location of boost headers")
set(LOCAL_BOOST_LIB_PREFIX "${LOCAL_BOOST_PREFIX}/lib" CACHE PATH "Location of boost libraries")

macro(add_boost_library libname)
    string(TOUPPER ${libname} libname_upper)

    add_library(boost_${libname}_debug STATIC IMPORTED GLOBAL)
    set_target_properties(boost_${libname}_debug PROPERTIES
            IMPORTED_LOCATION "${LOCAL_BOOST_LIB_PREFIX}/libboost_${libname}-debug.a"
            INTERFACE_COMPILE_DEFINITIONS "HAVE_BOOST_${libname_upper}_DEBUG")
    list(APPEND BOOST_LIBS_DEBUG "boost_${libname}_debug")

    add_library(boost_${libname}_release STATIC IMPORTED GLOBAL)
    set_target_properties(boost_${libname}_release PROPERTIES
            IMPORTED_LOCATION "${LOCAL_BOOST_LIB_PREFIX}/libboost_${libname}-release.a"
            INTERFACE_COMPILE_DEFINITIONS "HAVE_BOOST_${libname_upper}_RELEASE")
    list(APPEND BOOST_LIBS_RELEASE "boost_${libname}_release")
endmacro()

macro(setup_boost)
    message("Setting up boost...")
    message("Boost include_path=${LOCAL_BOOST_INCLUDE_PREFIX} lib_path=${LOCAL_BOOST_LIB_PREFIX} ")
    add_library(boost_debug INTERFACE IMPORTED)
    add_library(boost_release INTERFACE IMPORTED)

    # start boost libs (all these are linked to boost) - add more here.
    add_boost_library(program_options)
    # add_boost_library(another_lib)
    # end boost libs

    message("Static boost libs Debug: ${BOOST_LIBS_DEBUG}")
    message("Static boost libs Release: ${BOOST_LIBS_RELEASE}")

    set_target_properties(boost_debug PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_BOOST_INCLUDE_PREFIX}"
            INTERFACE_LINK_LIBRARIES "${BOOST_LIBS_DEBUG}"
            INTERFACE_COMPILE_DEFINITIONS "HAVE_BOOST_DEBUG")
    set_target_properties(boost_release PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LOCAL_BOOST_INCLUDE_PREFIX}"
            INTERFACE_LINK_LIBRARIES "${BOOST_LIBS_RELEASE}"
            INTERFACE_COMPILE_DEFINITIONS "HAVE_BOOST_RELEASE")
endmacro()
