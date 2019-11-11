# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.
cmake_minimum_required(VERSION 3.4.1)

# ValaAndroid: specify path to our cross-compiled glib binaries
set(_GLIB_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/")
set(_GLIB_LIBRARY      "${CMAKE_SOURCE_DIR}/lib/libglib-2.0.so.0")

# ValaAndroid: include all cmake files and find libvala
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ValaPrecompile.cmake)
find_package(Vala REQUIRED)

# ValaAndroid: precompile vala sources to C
vala_precompile(
    VALA_C PrecompileTarget
        MyValaFile.vala
    PACKAGES
        posix
    OPTIONS
        --thread
        --enable-experimental-non-null
#    CUSTOM_VAPIS
#        some_vapi.vapi
#    GENERATE_VAPI
#        MyLibVAPI
    GENERATE_HEADER
        MyLibHeader
)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

add_library( # Sets the name of the library.
        native-lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        native-lib.cpp

        # ValaAndroid: provide paths for our source files (which are listed in vala_precompile(...))
        ${VALA_C})

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

# ValaAndroid: link glib with our lib
include_directories("${_GLIB_INCLUDE_DIRS}")
target_link_libraries(
        native-lib

        "${_GLIB_LIBRARY}")

target_link_libraries( # Specifies the target library.
        native-lib

        # Links the target library to the log library
        # included in the NDK.
        ${log-lib})
