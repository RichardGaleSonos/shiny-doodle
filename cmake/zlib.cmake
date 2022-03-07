# Zlib Compression Library
#
# Zlib is a general-purpose, patent-free, lossless data compression
# library which is used by many different programs.
#
# http://zlib.net/
#
# Zlib

if (NOT ZLIB_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/zlib-build/install")
    set(EXTRA_CFLAGS "-Wno-error") # -I${CMAKE_SYSROOT}")
    set(EXTRA_LDFLAGS "")

    set(ZLIB_VERSION_STRING "1.2.11")

    ExternalProject_Add(
        zlib
        URL
            https://zlib.net/zlib-${ZLIB_VERSION_STRING}.tar.gz
        URL_HASH
            SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1
        CONFIGURE_COMMAND
            prefix=${PREFIX}
            CROSS_PREFIX=${TRIPLE}-
            CFLAGS=${EXTRA_CFLAGS}
            LDFLAGS=${EXTRA_LDFLAGS}
            ${CMAKE_BINARY_DIR}/zlib-prefix/src/zlib/configure

        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
    )

    set(ZLIB_INCLUDE_DIRS "${PREFIX}/include")
    set(ZLIB_LIBRARIES "${PREFIX}/lib")
    set(ZLIB_FOUND TRUE)
endif()

