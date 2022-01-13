cmake_minimum_required(VERSION 3.14)
project(heaptrack C)

# to build:
#   mkdir a113
#   cd a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake -DCMAKE_MAKE_PROGRAM=/usr/bin/make [path to CMakeLists.txt]
#   make install

# to install
#   cp -R ./heaptrack-build/install/ <path to /jffs/mnt>/a113
#   cp -R ./heaptrack-build/install/* /home/richardgale/git/pdsw-sonos-controller-player-s2/a113/

# sudo apt install heaptrack-gui

# heaptrack
# heaptrackfix
# heaptrack_gui

include(ExternalProject)

# sudo apt-get install libzstd-dev
# sudo apt-get install extra-cmake-modules
# sudo apt-get install qt5-default

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/../cmake)

include(libunwind)
include(zlib)

set(PREFIX "${CMAKE_BINARY_DIR}/heaptrack-build/install")


message("CMAKE_CROSSCOMPILING ${CMAKE_CROSSCOMPILING}")
if(${CMAKE_CROSSCOMPILING})
    set(HEAPTRACK_BUILD_GUI OFF)
    set(HEAPTRACK_BUILD_INTERPRET ON)
else()
    set(HEAPTRACK_BUILD_GUI ON)
    set(HEAPTRACK_BUILD_INTERPRET OFF)
endif()

ExternalProject_Add(
    heaptrack
    GIT_REPOSITORY
        "https://github.com/KDE/heaptrack"
    CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DHEAPTRACK_BUILD_GUI=${HEAPTRACK_BUILD_GUI}
        -DHEAPTRACK_BUILD_INTERPRET=${HEAPTRACK_BUILD_INTERPRET}
        -DHEAPTRACK_USE_LIBUNWIND=OFF
        -DCMAKE_INSTALL_PREFIX=${PREFIX}
        -DLIBUNWIND_LIBRARY=${LIBUNWIND_LIBRARIES}
        -DLIBUNWIND_INCLUDE_DIR=${LIBUNWIND_INCLUDE_DIRS}
        -DLIBUNWIND_VERSION_STRING=${LIBUNWIND_VERSION_STRING}
        -DZLIB_LIBRARY=${ZLIB_LIBRARIES}
        -DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIRS}
        -DZLIB_VERSION_STRING=${ZLIB_VERSION_STRING}
    DEPENDS
        libunwind zlib
)

install(
    FILES
        ${CMAKE_SOURCE_DIR}/readlink
    DESTINATION
        ${PREFIX}/bin
)
