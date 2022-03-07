if(NOT AVAHI_FOUND)
    # include(dbus)
    # include(expat)
    # include(libdaemon)
    # include(libevent)

    set(PREFIX "${CMAKE_BINARY_DIR}/dbus-build/install")
    set(DBUS_FOUND 1)
    set(DBUS_LIBRARIES "libdbus-1.so.3") # "libdbus-1.a"
    set(DBUS_LINK_LIBRARIES "${PREFIX}/lib/libdbus-1.so.3")
    set(DBUS_LIBRARY_DIRS "${PREFIX}/lib")
    set(DBUS_LDFLAGS)
    set(DBUS_LDFLAGS_OTHER)
    set(DBUS_INCLUDE_DIRS "${PREFIX}/include")
    set(DBUS_CFLAGS)
    set(DBUS_CFLAGS_OTHER)

    set(PREFIX "${CMAKE_BINARY_DIR}/expat-build/install")
    set(EXPAT_FOUND 1)
    set(EXPAT_LIBRARIES "libexpat.so.1") # "libexpat.a"
    set(EXPAT_LINK_LIBRARIES "${PREFIX}/lib/libexpat.so.1")
    set(EXPAT_LIBRARY_DIRS "${PREFIX}/lib")
    set(EXPAT_LDFLAGS)
    set(EXPAT_LDFLAGS_OTHER)
    set(EXPAT_INCLUDE_DIRS "${PREFIX}/include")
    set(EXPAT_CFLAGS)
    set(EXPAT_CFLAGS_OTHER)

    set(PREFIX "${CMAKE_BINARY_DIR}/libdaemon-build/install")
    set(LIBDAEMON_FOUND 1)
    set(LIBDAEMON_LIBRARIES "libdaemon.so.0") # "libdaemon.a")
    set(LIBDAEMON_LINK_LIBRARIES "${PREFIX}/lib/libdaemon.so.0")
    set(LIBDAEMON_LIBRARY_DIRS "${PREFIX}/lib")
    set(LIBDAEMON_LDFLAGS)
    set(LIBDAEMON_LDFLAGS_OTHER)
    set(LIBDAEMON_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBDAEMON_CFLAGS)
    set(LIBDAEMON_CFLAGS_OTHER)

    set(PREFIX "${CMAKE_BINARY_DIR}/libevent-build/install")
    set(LIBEVENT_FOUND 1)
    set(LIBEVENT_LIBRARIES "libevent-2.2.so.1") # "libevent.a"
    set(LIBEVENT_LINK_LIBRARIES "${PREFIX}/lib/libevent-2.2.so.1")
    set(LIBEVENT_LIBRARY_DIRS "${PREFIX}/lib")
    set(LIBEVENT_LDFLAGS)
    set(LIBEVENT_LDFLAGS_OTHER)
    set(LIBEVENT_INCLUDE_DIRS "${PREFIX}/include")
    set(LIBEVENT_CFLAGS)
    set(LIBEVENT_CFLAGS_OTHER)

    set(PREFIX "${CMAKE_BINARY_DIR}/avahi-build/install")

    ExternalProject_Add(
        avahi
        GIT_REPOSITORY
            http://github.com/lathiat/avahi.git
        CONFIGURE_COMMAND
            PKG_CONFIG_PATH=${DBUS_LIBRARY_DIRS}/pkgconfig

            LIBEVENT_CFLAGS=-I${LIBEVENT_INCLUDE_DIRS}
            LIBEVENT_LIBS=${LIBEVENT_LINK_LIBRARIES}

            LIBDAEMON_CFLAGS=-I${LIBDAEMON_INCLUDE_DIRS}
            LIBDAEMON_LIBS=${LIBDAEMON_LINK_LIBRARIES}

            ./bootstrap.sh
                "CPPFLAGS=-I${EXPAT_INCLUDE_DIRS} -I${DBUS_INCLUDE_DIRS}"
                "LDFLAGS=-lpthread -L${EXPAT_LIBRARY_DIRS} ${DBUS_LINK_LIBRARIES}"
                --prefix=${PREFIX}
                --host=${TRIPLE}
                --disable-silent-rules
                --sysconfdir=${PREFIX}

                --enable-shared
                --disable-static

                --with-distro=none
                --with-xml=expat

                --disable-glib
                --disable-qt4
                --disable-qt5
                --disable-gtk
                --disable-gtk3
                --disable-python
                --disable-mono
                --disable-monodoc
                --disable-doxygen-doc

                --disable-gdbm
                --disable-xmltoman
                --disable-manpages
                --disable-tests
                --disable-gobject
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
        BUILD_IN_SOURCE
            TRUE
        # DEPENDS
            # dbus
            # expat
            # libdaemon
            # libevent
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(AVAHI_FOUND 1)
    set(AVAHI_LIBRARIES "libavahi-client.so.3") # "libavahi-client.a"
    set(AVAHI_LINK_LIBRARIES "${PREFIX}/lib/libavahi-client.so.3")
    set(AVAHI_LIBRARY_DIRS "${PREFIX}/lib")
    set(AVAHI_LDFLAGS)
    set(AVAHI_LDFLAGS_OTHER)
    set(AVAHI_INCLUDE_DIRS "${PREFIX}/include")
    set(AVAHI_CFLAGS)
    set(AVAHI_CFLAGS_OTHER)
endif()
