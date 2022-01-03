# A library for atomic integer operations
#
# https://github.com/ivmai/libatomic_ops/
#
# GPLv2 & MIT

if (NOT LIBATOMIC_OPS_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/libatomic_ops-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT}")
    set(EXTRA_LDFLAGS "")

    set(LIBATOMIC_OPS_VERSION "7.6.12")

    ExternalProject_Add(
        libatomic_ops
        URL
            https://github.com/ivmai/libatomic_ops/releases/download/v${LIBATOMIC_OPS_VERSION}/libatomic_ops-${LIBATOMIC_OPS_VERSION}.tar.gz
        CONFIGURE_COMMAND
            ${CMAKE_BINARY_DIR}/libatomic_ops-prefix/src/libatomic_ops/configure
                # --enable-debug-frame
                --prefix=${PREFIX}
                --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu
                --host=${TRIPLE}
                --with-sysroot=${CMAKE_SYSROOT}
                CC=${CMAKE_C_COMPILER}
                LD=${CMAKE_LINKER}
                CFLAGS=${EXTRA_CFLAGS}
                LDFLAGS=${EXTRA_LDFLAGS}
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
    )

    set(LIBATOMIC_OPS_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBATOMIC_OPS_LIBRARIES "${PREFIX}/lib")
    set(LIBATOMIC_OPS_DIR "${PREFIX}")
    set(LIBATOMIC_OPS_FOUND TRUE)
endif()
