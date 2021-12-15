# Performance analysis tools for Linux
#
# Performance counters for Linux are a new kernel-based
# subsystem that provide a framework for all things
# performance analysis. It covers hardware level
# (CPU/PMU, Performance Monitoring Unit) features
# and software features (software counters, tracepoints)
# as well.
#
# https://perf.wiki.kernel.org/index.php/Main_Page
#
# LICENSE = "GPLv2"

cmake_minimum_required(VERSION 3.14)
project(perf C)

# to build:
#   mkdir a113
#   cd a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake [path to CMakeLists.txt]
#   make install

# to install
#   cp -R ./perf-build/install/ <path to /jffs/mnt>/a113
#   cp -R ./perf-build/install/* /home/richardgale/git/pdsw-sonos-controller-player-s2/a113/

# to run
#   LD_LIBRARY_PATH="/jffs/mnt/a113/lib:$LD_LIBRARY_PATH /jffs/mnt/a113/bin/perf

include(ExternalProject)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../cmake")

include(zlib)
include(xz)
include(bzip2)
include(elfutils)
include(openssl)
include(libunwind)

# PERF

set(PREFIX "${CMAKE_BINARY_DIR}/perf-build/install")

set(EXTRA_CFLAGS " -mcpu=cortex-a53 -march=armv8-a --sysroot=${CMAKE_SYSROOT} -Wno-unused-but-set-variable -Wno-unused-variable -Wno-nested-externs -Wno-implicit-function-declaration -Wno-logical-not-parentheses -D_DEFAULT_SOURCE -I${CMAKE_SYSROOT}/usr/include -I${LIBELF_INCLUDE_DIRS} -I${ZLIB_INCLUDE_DIRS} -I${LZMA_INCLUDE_DIRS} -I${BZIP2_INCLUDE_DIRS} -I${LIBDW_INCLUDE_DIRS} -I${LIBBFD_INCLUDE_DIRS} -I${LIBELF_INCLUDE_DIRS} -I${LIBCRYPTO_INCLUDE_DIRS} -I${LIBSSL_INCLUDE_DIRS} -I${LIBATOMIC_OPS_INCLUDE_DIRS}") # -I${LIBUNWIND_INCLUDE_DIRS}
set(EXTRA_LDFLAGS " -L${CMAKE_SYSROOT}/usr/lib -L${LIBELF_LIBRARIES} -L${LIBBFD_LIBRARIES} -lbfd -L${LIBDW_LIBRARIES} -ldw -L${LIBELF_LIBRARIES} -lelf -L${ZLIB_LIBRARIES} -lz -L${LZMA_LIBRARIES} -llzma -L${BZIP2_LIBRARIES} -lbz2 -L${LIBCRYPTO_LIBRARIES} -lcrypto -L${LIBSSL_LIBRARIES} -lssl -L${LIBATOMIC_OPS_LIBRARIES} -latomic_ops -L${LIBUNWIND_LIBRARIES} -lunwind")

make_directory(${CMAKE_BINARY_DIR}/perf-build)
make_directory(${CMAKE_BINARY_DIR}/perf-prefix/out)

ExternalProject_Add(
    perf
    PREFIX ${CMAKE_BINARY_DIR}/perf-prefix
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/linux-4.9.99/tools/perf
    CONFIGURE_COMMAND
        ""
    BUILD_COMMAND
        make
            -C ${CMAKE_SOURCE_DIR}/linux-4.9.99/tools/perf
            V=1
            VF=1
            O=${CMAKE_BINARY_DIR}/perf-prefix/out
            CROSS_COMPILE=${TRIPLE}-
            ARCH=arm64
            CC=${CMAKE_C_COMPILER}
            CCLD=${CMAKE_C_COMPILER}
            LDSHARED=${CMAKE_C_COMPILER}
            AR=${CMAKE_AR}
            LD=${CMAKE_LINKER}
            CFLAGS=${EXTRA_CFLAGS}
            LDFLAGS=${EXTRA_LDFLAGS}
            EXTRA_CFLAGS=${EXTRA_CFLAGS}
            EXTRA_LDFLAGS=${EXTRA_LDFLAGS}
            LIBUNWIND_DIR=${LIBUNWIND_DIR}
            LIBDW_DIR=${LIBDW_DIR}
            prefix=${PREFIX}
    INSTALL_COMMAND
        make
            -C ${CMAKE_SOURCE_DIR}/linux-4.9.99/tools/perf
            V=1
            VF=1
            O=${CMAKE_BINARY_DIR}/perf-prefix/out
            CROSS_COMPILE=${TRIPLE}-
            ARCH=arm64
            CC=${CMAKE_C_COMPILER}
            CCLD=${CMAKE_C_COMPILER}
            LDSHARED=${CMAKE_C_COMPILER}
            AR=${CMAKE_AR}
            LD=${CMAKE_LINKER}
            CFLAGS=${EXTRA_CFLAGS}
            LDFLAGS=${EXTRA_LDFLAGS}
            EXTRA_CFLAGS=${EXTRA_CFLAGS}
            EXTRA_LDFLAGS=${EXTRA_LDFLAGS}
            LIBUNWIND_DIR=${LIBUNWIND_DIR}
            LIBDW_DIR=${LIBDW_DIR}
            prefix=${PREFIX}
            install
    DEPENDS elfutils xz zlib bzip2 openssl libunwind libatomic_ops
)

install(
    FILES
        ${CMAKE_SYSROOT}/usr/lib/libbfd.so
        ${CMAKE_SYSROOT}/usr/lib/libbfd-2.28.so
    DESTINATION
        ${PREFIX}/lib
)

foreach(lib
    ${LZMA_LIBRARIES}
    ${LIBDW_LIBRARIES}
    ${LIBCRYPTO_LIBRARIES}
    ${LIBUNWIND_LIBRARIES}
)
    install(
        DIRECTORY
            ${lib}
        DESTINATION
            ${PREFIX}
        PATTERN "*.a" EXCLUDE
        PATTERN "*.la" EXCLUDE
        PATTERN "pkgconfig" EXCLUDE
    )
endforeach()

install(
    FILES
        ${CMAKE_BINARY_DIR}/perf-prefix/out/perf
        # ${CMAKE_BINARY_DIR}/perf-prefix/out/perf-archive
        # ${CMAKE_BINARY_DIR}/perf-prefix/out/perf-with-kcore
    DESTINATION
        ${PREFIX}/bin
)

# FEATURE DEBUGGING

# diff --git a/perf/linux-4.9.99/tools/build/feature/Makefile b/perf/linux-4.9.99/tools/build/feature/Makefile
# index ac9c477..31780af 100644
# --- a/perf/linux-4.9.99/tools/build/feature/Makefile
# +++ b/perf/linux-4.9.99/tools/build/feature/Makefile
# @@ -58,10 +58,10 @@ PKG_CONFIG := $(CROSS_COMPILE)pkg-config
#  all: $(FILES)

#  __BUILD = $(CC) $(CFLAGS) -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
# -  BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
# +  BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>$(@:.bin=.make.error)

#  __BUILDXX = $(CXX) $(CXXFLAGS) -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
# -  BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
# +  BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>$(@:.bin=.make.error)

#  ###############################
