# Utilities for managing LZMA compressed files
#
# https://tukaani.org/xz/
#
# GPLv2+ & GPL-3.0-with-autoconf-exception & LGPLv2.1+ & PD

if (NOT LZMA_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/xz-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT}")
    set(EXTRA_LDFLAGS "")

    ExternalProject_Add(
        xz
        URL
            https://tukaani.org/xz/xz-5.2.5.tar.gz
        CONFIGURE_COMMAND
            ${CMAKE_BINARY_DIR}/xz-prefix/src/xz/configure --prefix=${PREFIX} --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu --host=${TRIPLE_UNKNOWN} CC=${CMAKE_C_COMPILER} LD=${CMAKE_LINKER} CFLAGS=${EXTRA_CFLAGS} LDFLAGS=${EXTRA_LDFLAGS}
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
    )

    set(LZMA_INCLUDE_DIRS "${PREFIX}/include")
    set(LZMA_LIBRARIES "${PREFIX}/lib")
    set(LZMA_FOUND TRUE)
endif()