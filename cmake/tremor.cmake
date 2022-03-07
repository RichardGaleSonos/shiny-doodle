if(NOT TREMOR_FOUND)
    include(ogg)

    set(PREFIX "${CMAKE_BINARY_DIR}/tremor-build/install")

    ExternalProject_Add(
        tremor
        GIT_REPOSITORY
            https://gitlab.xiph.org/xiph/tremor
        CONFIGURE_COMMAND
            sed -i /XIPH_PATH_OGG/d configure.in
        COMMAND
            OGG_CFLAGS=-I${OGG_INCLUDE_DIRS} OGG_LIBS=${OGG_LIBRARIES}/libogg.so ./autogen.sh
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
        DEPENDS
            ogg
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(TREMOR_FOUND 1)
    set(TREMOR_LIBRARIES "libvorbisidec.so.1") # "libvorbisidec.a"
    set(TREMOR_LINK_LIBRARIES "${PREFIX}/lib/libvorbisidec.so.1")
    set(TREMOR_LIBRARY_DIRS "${PREFIX}/lib")
    set(TREMOR_LDFLAGS)
    set(TREMOR_LDFLAGS_OTHER)
    set(TREMOR_INCLUDE_DIRS "${PREFIX}/include")
    set(TREMOR_CFLAGS)
    set(TREMOR_CFLAGS_OTHER)
endif()
