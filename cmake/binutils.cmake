# GNU binary utilities
#
# The GNU Binutils are a collection of binary tools.
# The main ones are ld (GNU Linker), and as (GNU Assembler). This
# package also includes addition tools such as addr2line (Converts
# addresses into filenames and line numbers), ar (utility for creating,
# modifying and extracting archives), nm (list symbols in object
# files), objcopy (copy and translate object files), objdump (Display
# object information), and other tools and related libraries.
#
# http://www.gnu.org/software/binutils/
#
# GPLv3

if(NOT BINUTILS_FOUND)
    set(PREFIX "${CMAKE_BINARY_DIR}/binutils-build/install")

    ExternalProject_Add(
        binutils
        URL
            https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.gz
        CONFIGURE_COMMAND
            ${CMAKE_BINARY_DIR}/binutils-prefix/src/binutils/configure
                --prefix=${PREFIX}
                --host=${TRIPLE}
                --without-x
                --enable-shared
                --disable-static

                --disable-share
                --disable-info
                --disable-infodir
                --disable-dataroot
                --disable-datarootdir
                --disable-data
                --disable-datadir
                --disable-doc
                --disable-docdir
                --disable-html
                --disable-htmldir
                --disable-man
                --disable-mandir
                --disable-nls
                --disable-dvi
                --disable-dvidir
                --disable-pdf
                --disable-pdfdir
                --disable-ps
                --disable-psdir
                --disable-texinfo
        BUILD_COMMAND
            make
        INSTALL_COMMAND
            make install
    )

    set(BINUTILS_INCLUDE_DIRS "${PREFIX}/include")
    set(BINUTILS_LIBRARIES "${PREFIX}/lib")
    set(BINUTILS_FOUND TRUE)
endif()
