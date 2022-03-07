if(NOT FLAC_FOUND)
    include(ogg)

    set(PREFIX "${CMAKE_BINARY_DIR}/flac-build/install")

    ExternalProject_Add(
        flac
        GIT_REPOSITORY
            https://github.com/xiph/flac.git
        CONFIGURE_COMMAND
            ./autogen.sh
        COMMAND
            ./configure
                --prefix=${PREFIX}
                --host=${TRIPLE}
                --with-ogg=${CMAKE_BINARY_DIR}/ogg-build/install

                --enable-shared
                --disable-static
        BUILD_COMMAND
            # HACK: LIBS does not include OGG_LIBS
            make LDFLAGS="-L${CMAKE_BINARY_DIR}/ogg-build/install/lib -logg"
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
        DEPENDS
            ogg
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(FLAC_FOUND 1)
    set(FLAC_LIBRARIES "libFLAC.so.8") # "libFLAC.a"
    set(FLAC_LINK_LIBRARIES "${PREFIX}/lib/libFLAC.so.8")
    set(FLAC_LIBRARY_DIRS "${PREFIX}/lib")
    set(FLAC_LDFLAGS)
    set(FLAC_LDFLAGS_OTHER)
    set(FLAC_INCLUDE_DIRS "${PREFIX}/include")
    set(FLAC_CFLAGS)
    set(FLAC_CFLAGS_OTHER)
endif()
