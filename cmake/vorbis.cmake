if(NOT VORBIS_FOUND)
    include(ogg)

    set(PREFIX "${CMAKE_BINARY_DIR}/vorbis-build/install")

    ExternalProject_Add(
        vorbis
        GIT_REPOSITORY
            https://github.com/xiph/vorbis.git
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
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
        DEPENDS
            ogg
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(VORBIS_FOUND 1)
    set(VORBIS_LIBRARIES "libvorbis.so.0") # "libvorbis.a"
    set(VORBIS_LINK_LIBRARIES "${PREFIX}/lib/libvorbis.so.0")
    set(VORBIS_LIBRARY_DIRS "${PREFIX}/lib")
    set(VORBIS_LDFLAGS)
    set(VORBIS_LDFLAGS_OTHER)
    set(VORBIS_INCLUDE_DIRS "${PREFIX}/include")
    set(VORBIS_CFLAGS)
    set(VORBIS_CFLAGS_OTHER)

    set(VORBISENC_FOUND 1)
    set(VORBISENC_LIBRARIES "libvorbisenc.so.2") # "libvorbisenc.a"
    set(VORBISENC_LINK_LIBRARIES "${PREFIX}/lib/libvorbisenc.so.2")
    set(VORBISENC_LIBRARY_DIRS "${PREFIX}/lib")
    set(VORBISENC_LDFLAGS)
    set(VORBISENC_LDFLAGS_OTHER)
    set(VORBISENC_INCLUDE_DIRS "${PREFIX}/include")
    set(VORBISENC_CFLAGS)
    set(VORBISENC_CFLAGS_OTHER)
endif()
