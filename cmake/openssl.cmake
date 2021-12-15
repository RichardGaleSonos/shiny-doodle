# Secure Socket Layer
#
# Secure Socket Layer (SSL) binary and related cryptographic tools.
#
# http://www.openssl.org/
#
# openssl

if (NOT LIBSSL_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/openssl-build/install")
    set(EXTRA_CFLAGS "-I${CMAKE_SYSROOT}") # -fPIC -fpic -Winline -fno-strength-reduce -D_FILE_OFFSET_BITS=64")
    set(EXTRA_LDFLAGS "")

    set(LIBSSL_VERSION "1.1")

    ExternalProject_Add(
        openssl
        URL
            https://www.openssl.org/source/openssl-${LIBSSL_VERSION}.1l.tar.gz
        CONFIGURE_COMMAND
            perl ${CMAKE_BINARY_DIR}/openssl-prefix/src/openssl/Configure
            --with-rand-seed=os,devrandom
            --prefix=${PREFIX}
            --cross-compile-prefix=${TRIPLE}-
            --openssldir=${PREFIX}/lib/ssl-1.1
            --libdir=${PREFIX}/lib
            CFLAGS=${EXTRA_CFLAGS}
            LDFLAGS=${EXTRA_LDFLAGS}
            linux-${CMAKE_SYSTEM_PROCESSOR}
        COMMAND
            perl configdata.pm --dump
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install_sw
    )

    set(LIBCRYPTO_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBCRYPTO_LIBRARIES "${PREFIX}/lib")
    set(LIBCRYPTO_FOUND TRUE)

    set(LIBSSL_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBSSL_LIBRARIES "${PREFIX}/lib")
    set(LIBSSL_FOUND TRUE)
endif()
