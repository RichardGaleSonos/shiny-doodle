# Library for obtaining the call-chain of a program
#
# a portable and efficient C programming interface (API) to determine the call-chain of a program
#
# http://www.nongnu.org/libunwind
#
# MIT

if (NOT LIBUNWIND_FOUND)
    include(libatomic_ops)
    include(xz)

    set(PREFIX "${CMAKE_BINARY_DIR}/libunwind-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT} -I${LZMA_INCLUDE_DIRS} -I${LIBATOMIC_OPS_INCLUDE_DIRS}")
    set(EXTRA_LDFLAGS "-L${LZMA_LIBRARIES} -llzma -L${LIBATOMIC_OPS_LIBRARIES} -latomic_ops")

    # set(LIBUNWIND_VERSION "1.6.2")
    set(LIBUNWIND_VERSION "1.3.1") # version in yocto+patches

    ExternalProject_Add(
        libunwind
        URL
            http://download.savannah.nongnu.org/releases/libunwind/libunwind-${LIBUNWIND_VERSION}.tar.gz
        CONFIGURE_COMMAND
            ${CMAKE_BINARY_DIR}/libunwind-prefix/src/libunwind/configure
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
        DEPENDS
            libatomic_ops xz
    )

    set(LIBUNWIND_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBUNWIND_LIBRARIES "${PREFIX}/lib")
    set(LIBUNWIND_DIR "${PREFIX}")
    set(LIBUNWIND_FOUND TRUE)
endif()
