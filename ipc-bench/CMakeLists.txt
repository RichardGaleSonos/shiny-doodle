cmake_minimum_required(VERSION 3.14)
project(ipc-bench C)

# to build:
#   mkdir a113
#   cd a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake -DCMAKE_MAKE_PROGRAM=/usr/bin/make [path to CMakeLists.txt]
#   make install

# to install
#   cp -R ./install <path to /jffs/mnt>/a113/ipc-bench

include(ExternalProject)

set(PREFIX "${CMAKE_BINARY_DIR}/install")

ExternalProject_Add(
    ipc-bench
    GIT_REPOSITORY
        "https://github.com/goldsborough/ipc-bench.git"
    PATCH_COMMAND
        patch -p1 < ${CMAKE_CURRENT_LIST_DIR}/0001-Use-cwd-for-build_path.patch
    CONFIGURE_COMMAND
        cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_MAKE_PROGRAM=/usr/bin/make ${CMAKE_BINARY_DIR}/ipc-bench-prefix/src/ipc-bench
    INSTALL_COMMAND
        ""
)

install(
    DIRECTORY
        ${CMAKE_BINARY_DIR}/ipc-bench-prefix/src/ipc-bench-build/source
    DESTINATION
        ${PREFIX}/build
)
