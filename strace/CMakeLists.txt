cmake_minimum_required(VERSION 3.14)
project(strace C)

# to build:
#   mkdir a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake [path to CMakeLists.txt]
#   make install
# installable binaries in
#   a113/strace/a113/strace-build/install

include(ExternalProject)

set(PREFIX "${CMAKE_BINARY_DIR}/strace-build/install")

ExternalProject_Add(
    strace
    GIT_REPOSITORY
    "https://github.com/strace/strace.git"
    UPDATE_COMMAND ${CMAKE_BINARY_DIR}/strace-prefix/src/strace/bootstrap
    CONFIGURE_COMMAND ${CMAKE_BINARY_DIR}/strace-prefix/src/strace/configure --enable-mpers=no --prefix=${PREFIX} --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu --host=${TRIPLE}
    BUILD_IN_SOURCE TRUE
)

install(
    FILES ${CMAKE_SYSROOT}/lib/librt.so.1 ${CMAKE_SYSROOT}/lib/librt-2.23.so
    DESTINATION ${PREFIX}/bin
)