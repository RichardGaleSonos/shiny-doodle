# TODO:REG add qa checks from insane.bbclass

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(TRIPLE "aarch64-ca53v2-linux-gnueabi")
set(TRIPLE_UNKNOWN "aarch64-unknown-linux-gnueabi")

set(CMAKE_SYSROOT /usr/local/toolchain/${TRIPLE}/${TRIPLE}/sysroot)

set(CMAKE_C_COMPILER ${TRIPLE}-gcc)
set(CMAKE_CXX_COMPILER ${TRIPLE}-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_LINKER ${TRIPLE}-ld)
set(CMAKE_AR ${TRIPLE}-ar)
set(CMAKE_RANLIB ${TRIPLE}-ranlib)
set(CMAKE_STRIP ${TRIPLE}-strip)
set(CMAKE_OBJDUMP ${TRIPLE}-objdump)

# snapcast

# set(TRIPLE "aarch64-ca53v5-linux-gnu")
# set(TRIPLE_UNKNOWN "aarch64-unknown-linux-gnu")

# set(CMAKE_SYSROOT /usr/local/toolchain/${TRIPLE}/${TRIPLE}/sysroot)

# set(CMAKE_C_COMPILER /usr/local/bin/${TRIPLE}-gcc)
# set(CMAKE_CXX_COMPILER /usr/local/bin/${TRIPLE}-g++)
# set(CMAKE_AR /usr/local/bin/${TRIPLE}-ar)

# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# set(CMAKE_LINKER ${TRIPLE}-ld)
# set(CMAKE_AR ${TRIPLE}-ar)
# set(CMAKE_RANLIB ${TRIPLE}-ranlib)
# set(CMAKE_STRIP ${TRIPLE}-strip)

# include_directories(SYSTEM /home/richardgale/git/pdsw-sonos-controller-player-s2/platforms/yocto/build-oprofile-valgrind/apollo-build/tmp/work/aarch64-sonos-linux/alsa-lib/1.1.7-r0/sysroot-destdir/usr/include)
# link_directories(/home/richardgale/git/pdsw-sonos-controller-player-s2/platforms/yocto/build-oprofile-valgrind/apollo-build/tmp/work/aarch64-sonos-linux/alsa-lib/1.1.7-r0/sysroot-destdir/usr/lib)
