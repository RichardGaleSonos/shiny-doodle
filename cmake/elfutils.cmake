# Utilities and libraries for handling compiled object files
#
# https://sourceware.org/elfutils
#
# GPLv2 & LGPLv3+ & GPLv3+

if (NOT LIBELF_FOUND)
    include(zlib)
    include(xz)
    include(bzip2)

    set(PREFIX "${CMAKE_BINARY_DIR}/elfutils-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT} -I${ZLIB_INCLUDE_DIRS} -I${LZMA_INCLUDE_DIRS} -I${BZIP2_INCLUDE_DIRS}")
    set(EXTRA_LDFLAGS "-L${ZLIB_LIBRARIES} -lz -L${LZMA_LIBRARIES} -llzma -L${BZIP2_LIBRARIES} -lbz2")

    set(ELFUTILS_VERSION "0.186")

    ExternalProject_Add(
        elfutils
        URL
            https://sourceware.org/elfutils/ftp/0.186/elfutils-${ELFUTILS_VERSION}.tar.bz2
        CONFIGURE_COMMAND
            autoreconf -i -f ${CMAKE_BINARY_DIR}/elfutils-prefix/src/elfutils/
        COMMAND
            ${CMAKE_BINARY_DIR}/elfutils-prefix/src/elfutils/configure
                --program-prefix=eu-
                --disable-debuginfod
                --enable-libdebuginfod=no
                --prefix=${PREFIX}
                --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu
                --host=${TRIPLE_UNKNOWN}
                CC=${CMAKE_C_COMPILER}
                LD=${CMAKE_LINKER}
                CFLAGS=${EXTRA_CFLAGS}
                LDFLAGS=${EXTRA_LDFLAGS}
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        DEPENDS
            zlib xz bzip2
    )

    set(LIBDW_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBDW_LIBRARIES "${PREFIX}/lib")
    set(LIBDW_DIR "${PREFIX}")
    set(LIBDW_FOUND TRUE)

    set(LIBBFD_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBBFD_LIBRARIES "${PREFIX}/lib")
    set(LIBBFD_FOUND TRUE)

    set(LIBELF_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBELF_LIBRARIES "${PREFIX}/lib")
    set(LIBELF_FOUND TRUE)
endif()
