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

    ExternalProject_Add(
        openssl
        URL
            https://www.openssl.org/source/openssl-1.1.1l.tar.gz
        CONFIGURE_COMMAND
            perl ${CMAKE_BINARY_DIR}/openssl-prefix/src/openssl/Configure --cross-compile-prefix=${TRIPLE}- CFLAGS=${EXTRA_CFLAGS} LDFLAGS=${EXTRA_LDFLAGS} --with-rand-seed=os,devrandom ${PACKAGECONFIG_CONFARGS} --prefix=${PREFIX} --openssldir=${PREFIX}/lib/ssl-1.1 --libdir=${PREFIX}/lib linux-${CMAKE_SYSTEM_PROCESSOR}
        COMMAND
            perl configdata.pm --dump
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install_sw
        #BUILD_IN_SOURCE TRUE
    )

    set(LIBCRYPTO_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBCRYPTO_LIBRARIES "${PREFIX}/lib")
    set(LIBCRYPTO_FOUND TRUE)

    set(LIBSSL_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBSSL_LIBRARIES "${PREFIX}/lib")
    set(LIBSSL_FOUND TRUE)
endif()
