# iftop does for network usage what top(1) does for CPU usage
# http://www.ex-parrot.com/pdw/iftop/

# PRE-REQUISITES
#
# tic version >= 6.2
# $ tic -V
# ncurses 6.2.20200212

# to build
#   mkdir x64
#   cd x64
#   wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz
#   tar -xvf ncurses-6.2.tar.gz
#   cd ncurses-6.2/
#   ./configure
#   make
#   sudo make install

# to build:
#   mkdir a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=[path to]/cmake/a113.cmake [path to CMakeLists.txt]
#   make install

# to install
#   cp -R ./install <path to /jffs/mnt>/a113
#   chmod u=rwx /jffs/mnt/a113/sbin/iftop

# to run
#   LD_LIBRARY_PATH="/jffs/mnt/a113/lib:$LD_LIBRARY_PATH" TERMINFO=/jffs/mnt/a113/share/terminfo/ /jffs/mnt/a113/sbin/iftop -i br0 -B -P -p

cmake_minimum_required(VERSION 3.14)
project(iftop CXX)

include(ExternalProject)

# libpcap

set(LIBPCAP_VERSION "1.9.1")

ExternalProject_Add(
    libpcap
    URL
        "https://www.tcpdump.org/release/libpcap-${LIBPCAP_VERSION}.tar.gz"
    CONFIGURE_COMMAND
        CFLAGS=-I${CMAKE_SYSROOT} ${CMAKE_BINARY_DIR}/libpcap-prefix/src/libpcap/configure --prefix=${CMAKE_BINARY_DIR}/libpcap-build/install --host=${TRIPLE} --with-pcap=linux
)

# ncurses

set(NCURSES_VERSION "6.2")

ExternalProject_Add(
    ncurses
    URL
        "https://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
    CONFIGURE_COMMAND
        ${CMAKE_BINARY_DIR}/ncurses-prefix/src/ncurses/configure --prefix=${CMAKE_BINARY_DIR}/ncurses-build/install --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu --host=${TRIPLE} AWK=gawk --disable-stripping --with-build-cc=/usr/bin/cc --with-fallbacks
)

set(IFTOP_VERSION "0.17")

ExternalProject_Add(
    iftop
    URL
        "https://www.ex-parrot.com/pdw/iftop/download/iftop-${IFTOP_VERSION}.tar.gz"
    CONFIGURE_COMMAND
        CFLAGS=-I${CMAKE_BINARY_DIR}/ncurses-build/install/include CPPFLAGS=-I${CMAKE_BINARY_DIR}/ncurses-build/install/include/ncurses LDFLAGS=-L${CMAKE_BINARY_DIR}/ncurses-build/install/lib CC=${CMAKE_C_COMPILER} LD=${CMAKE_LINKER} STRIP=${CMAKE_STRIP} ${CMAKE_BINARY_DIR}/iftop-prefix/src/iftop/configure --prefix=${CMAKE_BINARY_DIR}/iftop-build/install --build=${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-linux-gnu --host=${TRIPLE_UNKNOWN} --with-libpcap=${CMAKE_BINARY_DIR}/libpcap-build/install
    BUILD_IN_SOURCE TRUE
    DEPENDS
        libpcap ncurses
)

install(
    DIRECTORY ${CMAKE_BINARY_DIR}/ncurses-build/install/
    DESTINATION ${CMAKE_BINARY_DIR}/install
)
install(
    DIRECTORY ${CMAKE_BINARY_DIR}/libpcap-build/install/
    DESTINATION ${CMAKE_BINARY_DIR}/install
)
install(
    DIRECTORY ${CMAKE_BINARY_DIR}/iftop-build/install/
    DESTINATION ${CMAKE_BINARY_DIR}/install
)
