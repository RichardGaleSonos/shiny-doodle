if(NOT DBUS_FOUND)
    include(expat)

    set(PREFIX "${CMAKE_BINARY_DIR}/dbus-build/install")

    ExternalProject_Add(
        dbus
        GIT_REPOSITORY
            https://github.com/freedesktop/dbus.git
        CONFIGURE_COMMAND
            # NOTE: does not work EXPAT_CFLAGS=-I${EXPAT_INCLUDE_DIRS}
            # NOTE: does not work EXPAT_LIBS=-L${EXPAT_LIBRARY_DIRS}
            CFLAGS=-I${EXPAT_INCLUDE_DIRS}
            LDFLAGS=-L${EXPAT_LIBRARY_DIRS}
            ./autogen.sh
                --prefix=${PREFIX}
                --host=${TRIPLE}

                --disable-maintainer-mode
                --disable-developer
                --enable-shared
                --disable-static

                --disable-xml-docs
                --disable-doxygen-docs
                --disable-ducktype-docs
                --disable-tests
                --disable-installed-tests
                --disable-qt-help

                --without-x
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
        DEPENDS
            expat
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(DBUS_FOUND 1)
    set(DBUS_LIBRARIES "libdbus-1.so.3") # "libdbus-1.a"
    set(DBUS_LINK_LIBRARIES "${PREFIX}/lib/libdbus-1.so.3")
    set(DBUS_LIBRARY_DIRS "${PREFIX}/lib")
    set(DBUS_LDFLAGS)
    set(DBUS_LDFLAGS_OTHER)
    set(DBUS_INCLUDE_DIRS "${PREFIX}/include")
    set(DBUS_CFLAGS)
    set(DBUS_CFLAGS_OTHER)
endif()
