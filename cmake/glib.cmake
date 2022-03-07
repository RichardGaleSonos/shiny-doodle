if(NOT GLIB_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/glib-build/install")

    set(CROSS_FILE
        "[binaries]"
        "c = '${CMAKE_C_COMPILER}'"
        "cpp = '${CMAKE_CXX_COMPILER}'"
        "ld = '${CMAKE_LINKER}'"
        "ar = '${CMAKE_AR}'"
        "strip = '${CMAKE_STRIP}'"
        ""
        "sys_root = '${CMAKE_SYSROOT}'"
        ""
        "[host_machine]"
        "system = '${CMAKE_SYSTEM_NAME}'"
        "cpu_family = '${CMAKE_SYSTEM_PROCESSOR}'"
        "cpu = '${CMAKE_SYSTEM_PROCESSOR}'"
        "endian = 'little'"
    )
    string(REPLACE ";" "\n" CROSS_FILE "${CROSS_FILE}")
    file(WRITE "${CMAKE_BINARY_DIR}/glib-build/cross_file.txt" "${CROSS_FILE}")

    ExternalProject_Add(
        glib
        GIT_REPOSITORY
            https://github.com/GNOME/glib.git
        GIT_TAG
            origin/main
        CONFIGURE_COMMAND
            meson --cross-file "${CMAKE_BINARY_DIR}/glib-build/cross_file.txt" ${CMAKE_BINARY_DIR}/glib-prefix/src/glib ${CMAKE_BINARY_DIR}/glib-build
        BUILD_COMMAND
            ninja -C ${CMAKE_BINARY_DIR}/glib-build
        INSTALL_COMMAND
            ninja -C ${CMAKE_BINARY_DIR}/glib-build install
    )

    set(GLIB_INCLUDE_DIRS "${PREFIX}/include")
    set(GLIB_LIBRARIES "${PREFIX}/lib")
    set(GLIB_FOUND 1)
endif()
