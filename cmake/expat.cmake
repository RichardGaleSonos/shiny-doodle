if(NOT EXPAT_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/expat-build/install")

    ExternalProject_Add(
        expat
        GIT_REPOSITORY
            https://github.com/libexpat/libexpat.git
        CONFIGURE_COMMAND
            cd expat && ./buildconf.sh
        COMMAND
            cd expat && ./configure
                --prefix=${PREFIX}
                --host=${TRIPLE}
                --without-examples
                --without-tests
                --without-docbook

                --enable-shared
                --disable-static
        BUILD_COMMAND
            cd expat && make
        INSTALL_COMMAND
            cd expat && make install
        BUILD_IN_SOURCE
            TRUE
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(EXPAT_FOUND 1)
    set(EXPAT_LIBRARIES "libexpat.so.1") # "libexpat.a"
    set(EXPAT_LINK_LIBRARIES "${PREFIX}/lib/libexpat.so.1")
    set(EXPAT_LIBRARY_DIRS "${PREFIX}/lib")
    set(EXPAT_LDFLAGS)
    set(EXPAT_LDFLAGS_OTHER)
    set(EXPAT_INCLUDE_DIRS "${PREFIX}/include")
    set(EXPAT_CFLAGS)
    set(EXPAT_CFLAGS_OTHER)
endif()
