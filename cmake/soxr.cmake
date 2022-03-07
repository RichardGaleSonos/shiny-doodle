if(NOT SOXR_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/soxr-build/install")

    ExternalProject_Add(
        soxr
        GIT_REPOSITORY
            https://github.com/chirlu/soxr.git
        CMAKE_ARGS
            -Wno-dev -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_INSTALL_PREFIX=${PREFIX} DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 -DBUILD_SHARED_LIBS=1 -DBUILD_STATIC_LIBS=0
    )

    # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html?highlight=pkg_search_module
    set(SOXR_FOUND 1)
    set(SOXR_LIBRARIES "libsoxr.so.0") # "libsoxr.a"
    set(SOXR_LINK_LIBRARIES "${PREFIX}/lib/libsoxr.so.0")
    set(SOXR_LIBRARY_DIRS "${PREFIX}/lib")
    set(SOXR_LDFLAGS)
    set(SOXR_LDFLAGS_OTHER)
    set(SOXR_INCLUDE_DIRS "${PREFIX}/include")
    set(SOXR_CFLAGS)
    set(SOXR_CFLAGS_OTHER)
endif()
