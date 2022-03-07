# TODO:REG add qa checks from insane.bbclass

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(TRIPLE "arm-ca7v3-linux-gnueabihf")
set(TRIPLE_UNKNOWN "arm-unknown-linux-gnueabihf")

set(CMAKE_SYSROOT /usr/local/toolchain/${TRIPLE}/${TRIPLE}/sysroot)

set(CMAKE_C_COMPILER ${TRIPLE}-gcc)
set(CMAKE_CXX_COMPILER ${TRIPLE}-g++)
set(CMAKE_AR ${TRIPLE}-ar)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_LINKER ${TRIPLE}-ld)
set(CMAKE_AR ${TRIPLE}-ar)
set(CMAKE_RANLIB ${TRIPLE}-ranlib)
set(CMAKE_STRIP ${TRIPLE}-strip)
set(CMAKE_OBJDUMP ${TRIPLE}-objdump)
