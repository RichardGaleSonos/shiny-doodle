if(NOT LIBEVENT_FOUND)
    include(openssl)

    set(PREFIX "${CMAKE_BINARY_DIR}/libevent-build/install")

    ExternalProject_Add(
        libevent
        GIT_REPOSITORY
            https://github.com/libevent/libevent
        CONFIGURE_COMMAND
            ./autogen.sh
        COMMAND
            ./configure
                CFLAGS=-I${LIBSSL_INCLUDE_DIRS}
                LDFLAGS=-L${LIBSSL_LIBRARIES}

                --prefix=${PREFIX}
                --host=${TRIPLE}

                --disable-libevent-regress
                --disable-samples

                --enable-shared
                --disable-static
                --disable-doxygen-doc
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
        DEPENDS
            openssl
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(LIBEVENT_FOUND 1)
    set(LIBEVENT_LIBRARIES "libevent-2.2.so.1") # "libevent.a"
    set(LIBEVENT_LINK_LIBRARIES "${PREFIX}/lib/libevent-2.2.so.1")
    set(LIBEVENT_LIBRARY_DIRS "${PREFIX}/lib")
    set(LIBEVENT_LDFLAGS)
    set(LIBEVENT_LDFLAGS_OTHER)
    set(LIBEVENT_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBEVENT_CFLAGS)
    set(LIBEVENT_CFLAGS_OTHER)
endif()
