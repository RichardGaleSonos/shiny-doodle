if(NOT ALSA_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/alsa-build/install")

    ExternalProject_Add(
        alsa
        GIT_REPOSITORY
            https://github.com/alsa-project/alsa-lib.git
        CONFIGURE_COMMAND
            pwd
        COMMAND
            libtoolize --force --copy --automake
        COMMAND
            aclocal
        COMMAND
            autoheader
        COMMAND
            automake --foreign --copy --add-missing
        COMMAND
            autoconf
        COMMAND
            ./configure
                --prefix=${PREFIX}
                --host=${TRIPLE}

                --enable-shared
                --disable-static
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(ALSA_FOUND 1)
    set(ALSA_LIBRARIES "libasound.so.2") # "libasound.a"
    set(ALSA_LINK_LIBRARIES "${PREFIX}/lib/libasound.so.2")
    set(ALSA_LIBRARY_DIRS "${PREFIX}/lib")
    set(ALSA_LDFLAGS)
    set(ALSA_LDFLAGS_OTHER)
    set(ALSA_INCLUDE_DIRS "${PREFIX}/include")
    set(ALSA_CFLAGS)
    set(ALSA_CFLAGS_OTHER)
endif()
