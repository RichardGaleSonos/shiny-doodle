if(NOT OPUS_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/opus-build/install")

    ExternalProject_Add(
        opus
        GIT_REPOSITORY
            https://github.com/xiph/opus.git
        CONFIGURE_COMMAND
            ./autogen.sh
        COMMAND
            ./configure
                --prefix=${PREFIX}
                --host=${TRIPLE}

                --enable-shared
                --disable-static
                --disable-doc
                --disable-extra-programs
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(OPUS_FOUND 1)
    set(OPUS_LIBRARIES "libopus.so.0") # "libopus.a"
    set(OPUS_LINK_LIBRARIES "${PREFIX}/lib/libopus.so.0")
    set(OPUS_LIBRARY_DIRS "${PREFIX}/lib")
    set(OPUS_LDFLAGS)
    set(OPUS_LDFLAGS_OTHER)
    set(OPUS_INCLUDE_DIRS "${PREFIX}/include")
    set(OPUS_CFLAGS)
    set(OPUS_CFLAGS_OTHER)
endif()
