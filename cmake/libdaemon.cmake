if(NOT LIBDAEMON_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/libdaemon-build/install")

    ExternalProject_Add(
        libdaemon
        GIT_REPOSITORY
            git://git.0pointer.net/libdaemon.git
        CONFIGURE_COMMAND
            # from https://vanducuy.wordpress.com/2009/11/19/libdaemon-0-14-cross-compile-error/
            ac_cv_func_getpgrp_void=n
            ac_cv_func_setpgrp_void=ye
            ac_cv_func_memcmp_working=yes
            rb_cv_binary_elf=no
            rb_cv_negative_time_t=no

            ./bootstrap.sh
                --prefix=${PREFIX}
                --host=${TRIPLE}

                --enable-shared
                --disable-static
                --disable-lynx
                --disable-examples
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(LIBDAEMON_FOUND 1)
    set(LIBDAEMON_LIBRARIES "libdaemon.so.0") # "libdaemon.a")
    set(LIBDAEMON_LINK_LIBRARIES "${PREFIX}/lib/libdaemon.so.0")
    set(LIBDAEMON_LIBRARY_DIRS "${PREFIX}/lib")
    set(LIBDAEMON_LDFLAGS)
    set(LIBDAEMON_LDFLAGS_OTHER)
    set(LIBDAEMON_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBDAEMON_CFLAGS)
    set(LIBDAEMON_CFLAGS_OTHER)
endif()
