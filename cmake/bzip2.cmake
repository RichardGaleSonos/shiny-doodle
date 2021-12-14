# Very high-quality data compression program
#
# bzip2 compresses files using the Burrows-Wheeler block-sorting text compression algorithm, and
# Huffman coding. Compression is generally considerably better than that achieved by more conventional
# LZ77/LZ78-based compressors, and approaches the performance of the PPM family of statistical compressors.
#
# https://sourceware.org/bzip2/
#
# bzip2-1.0.6

if (NOT BZIP2_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/bzip2-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT} -fPIC -fpic -Winline -fno-strength-reduce -D_FILE_OFFSET_BITS=64")
    set(EXTRA_LDFLAGS "")

    set(BZIP2_VERSION "1.0.8")

    ExternalProject_Add(
        bzip2
        URL
            https://www.sourceware.org/pub/bzip2/bzip2-${BZIP2_VERSION}.tar.gz
        CONFIGURE_COMMAND
            ""
        BUILD_COMMAND
            make bzip2
                CC=${CMAKE_C_COMPILER}
                LD=${CMAKE_LINKER}
                CFLAGS=${EXTRA_CFLAGS}
                LDFLAGS=${EXTRA_LDFLAGS}
                RANLIB=${TRIPLE}-ranlib
        INSTALL_COMMAND
            make install
                PREFIX=${PREFIX}
        BUILD_IN_SOURCE TRUE
    )

    set(BZIP2_INCLUDE_DIRS "${PREFIX}/include")
    set(BZIP2_LIBRARIES "${PREFIX}/lib")
    set(BZIP2_FOUND TRUE)
endif()
