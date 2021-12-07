cmake_minimum_required(VERSION 3.14)
project(strace C)

# to build:
#   mkdir a113
#   cd a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake [path to CMakeLists.txt]
#   make install

# to install
#   cp -R ./install <path to /jffs/mnt>/a113

include(ExternalProject)

# set(PREFIX "${CMAKE_BINARY_DIR}/install")
set(XXX ${CMAKE_SOURCE_DIR}/linux-4.9.99)

set(TRIPLE "aarch64-ca53v2-linux-gnueabi")
set(SYSROOT /usr/local/toolchain/${TRIPLE}/${TRIPLE}/sysroot)

set(HOST ${TRIPLE}-)

ExternalProject_Add(
    perf
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/linux-4.9.99
    CONFIGURE_COMMAND ""
    BUILD_IN_SOURCE TRUE
    BUILD_COMMAND
        make
        V=1
        -C ${XXX}/tools/perf
        VF=1
        O=${CMAKE_BINARY_DIR}
        CROSS_COMPILE=${HOST}
        ARCH=arm64
        CC="${HOST}gcc"
        CCLD="${HOST}gcc"
        LDSHARED="${HOST}gcc"
        AR="${HOST}gcc-ar"
        LD="${HOST}ld --sysroot=${SYSROOT} "
        EXTRA_CFLAGS=" -mcpu=cortex-a53 -march=armv8-a --sysroot=${SYSROOT} -Wno-unused-but-set-variable -Wno-unused-variable -Wno-nested-externs -Wno-implicit-function-declaration -Wno-logical-not-parentheses -D_DEFAULT_SOURCE -I${SYSROOT}/usr/include"
        EXTRA_LDFLAGS=" -L${SYSROOT}/usr/lib"
        TMPDIR="${XXX}/out"
        LIBUNWIND_DIR=${SYSROOT}/usr
        LIBDW_DIR=${SYSROOT}/usr
        perfexecdir=/usr/libexec
        DESTDIR="${XXX}/out"
        prefix="/usr"
        bindir="/usr/bin"
        sharedir="/usr/share"
        sysconfdir="/etc"
        perfexecdir="/usr/libexec/perf-core"
        ETC_PERFCONFIG="../etc"
        sharedir="share"
        mandir="share/man"
        infodir="share/info"
)

