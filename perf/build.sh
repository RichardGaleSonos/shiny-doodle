SYSROOT=/home/richardgale/git/meson_dev/platforms/yocto/build/apollo-build/tmp/work/a113-sonos-linux/perf/1.0-r9/recipe-sysroot
HOST=aarch64-ca53v2-linux-gnueabi-

# O=/home/richardgale/git/meson_dev/platforms/yocto/build/apollo-build/tmp/work/a113-sonos-linux/perf/1.0-r9/perf-1.0 \
# TMPDIR="/home/richardgale/git/meson_dev/platforms/yocto/build/apollo-build/tmp/work/a113-sonos-linux/perf/1.0-r9/perf-1.0" \
# 'DESTDIR=/home/richardgale/git/meson_dev/platforms/yocto/build/apollo-build/tmp/work/a113-sonos-linux/perf/1.0-r9/image' \
# -C /home/richardgale/git/perf/tools/perf \
# -C /home/richardgale/git/meson_dev/platforms/yocto/build/apollo-build/tmp/work/a113-sonos-linux/perf/1.0-r9/perf-1.0/tools/perf \
# O=/home/richardgale/git/perf/out \

#  -lz -ldw -liberty
# LDFLAGS="-static" \

make \
-j 8 \
V=1 \
-C /home/richardgale/git/perf/tools/perf \
VF=1 \
O=/home/richardgale/git/perf/out \
CROSS_COMPILE=${HOST} \
ARCH=arm64 \
CC="${HOST}gcc" \
CCLD="${HOST}gcc" \
LDSHARED="${HOST}gcc" \
AR="${HOST}gcc-ar" \
LD="${HOST}ld --sysroot=${SYSROOT} " \
EXTRA_CFLAGS=" -mcpu=cortex-a53 -march=armv8-a --sysroot=${SYSROOT} -Wno-unused-but-set-variable -Wno-unused-variable -Wno-nested-externs -Wno-implicit-function-declaration -Wno-logical-not-parentheses -D_DEFAULT_SOURCE -I${SYSROOT}/usr/include" \
EXTRA_LDFLAGS=" -L${SYSROOT}/usr/lib" \
TMPDIR="/home/richardgale/git/perf/out" \
LIBUNWIND_DIR=${SYSROOT}/usr \
LIBDW_DIR=${SYSROOT}/usr \
perfexecdir=/usr/libexec \
DESTDIR="/home/richardgale/git/perf/out" \
prefix="/usr" \
bindir="/usr/bin" \
sharedir="/usr/share" \
sysconfdir="/etc" \
perfexecdir="/usr/libexec/perf-core" \
ETC_PERFCONFIG="../etc" \
sharedir="share" \
mandir="share/man" \
infodir="share/info" \
"$@"

# NO_LIBPERL=1 \
# NO_LIBPYTHON=1 \
# NO_DWARF=1 \
# NO_NEWT=1 \
# NO_SLANG=1 \
# NO_GTK2=1 \
# NO_DEMANGLE=1 \
# NO_LIBELF=1 \
# NO_LIBUNWIND=1 \
# NO_BACKTRACE=1 \
# NO_LIBNUMA=1 \
# NO_LIBAUDIT=1 \
# NO_LIBBIONIC=1 \
# NO_LIBCRYPTO=1 \
# NO_LIBDW_DWARF_UNWIND=1 \
# NO_PERF_READ_VDSO32=1 \
# NO_PERF_READ_VDSOX32=1 \
# NO_ZLIB=1 \
# NO_LZMA=1 \
# NO_AUXTRACE=1 \
# NO_LIBBPF=1 \
# NO_SDT=1 \
# NO_JVMTI=1 \
