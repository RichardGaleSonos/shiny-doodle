if(NOT OGG_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/ogg-build/install")

    ExternalProject_Add(
        ogg
        GIT_REPOSITORY
            https://github.com/xiph/ogg.git
        CONFIGURE_COMMAND
            ./autogen.sh
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
    set(OGG_FOUND 1)
    set(OGG_LIBRARIES "libogg.so.0") # "libogg.a"
    set(OGG_LINK_LIBRARIES "${PREFIX}/lib/libogg.so.0")
    set(OGG_LIBRARY_DIRS "${PREFIX}/lib")
    set(OGG_LDFLAGS)
    set(OGG_LDFLAGS_OTHER)
    set(OGG_INCLUDE_DIRS "${PREFIX}/include")
    set(OGG_CFLAGS)
    set(OGG_CFLAGS_OTHER)
endif()
