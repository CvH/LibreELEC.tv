################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tvheadend42"
PKG_VERSION="219dc8e"
PKG_VERSION_NUMBER="4.3.999"
PKG_REV="112"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvheadend.org"
PKG_URL="https://github.com/tvheadend/tvheadend/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="tvheadend-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain curl dvb-tools libdvbcsa libiconv openssl pngquant:host Python:host bzip2 ffmpegx"
PKG_SECTION="service"
PKG_SHORTDESC="Tvheadend: a TV streaming server for Linux"
PKG_LONGDESC="Tvheadend ($PKG_VERSION_NUMBER): is a TV streaming server for Linux supporting DVB-S/S2, DVB-C, DVB-T/T2, IPTV, SAT>IP, ATSC and ISDB-T"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tvheadend Server 4.3"
PKG_ADDON_TYPE="xbmc.service"

# basic transcoding options
TVH_TRANSCODING="\
  --disable-ffmpeg_static \
  --disable-libfdkaac_static \
  --disable-libopus_static \
  --disable-libtheora \
  --disable-libtheora_static \
  --disable-libvorbis_static \
  --disable-libvpx_static \
  --disable-libx264_static \
  --disable-libx265_static \
  --enable-libav \
  --enable-libfdkaac \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265"


# hw specific transcoding options
if [ "$TARGET_ARCH" = x86_64 ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libva-intel-driver yasm" # intel-vaapi-driver for master
  TVH_TRANSCODING="$TVH_TRANSCODING \
    --enable-vaapi"
fi

if [[ "$PROJECT" =~ "RPi" ]]; then
  TVH_TRANSCODING="$TVH_TRANSCODING \
    --disable-libx265 \
    --enable-mmal \
    --enable-omx"
fi

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --arch=$TARGET_ARCH \
                           --cpu=$TARGET_CPU \
                           --cc=$CC \
                           $TVH_TRANSCODING \
                           --disable-avahi \
                           --enable-bundle \
                           --disable-dbus_1 \
                           --enable-dvbcsa \
                           --enable-dvben50221 \
                           --enable-hdhomerun_client \
                           --enable-hdhomerun_static \
                           --enable-epoll \
                           --enable-inotify \
                           --enable-pngquant \
                           --disable-nvenc \
                           --disable-uriparser \
                           --disable-pcre2 \
                           --enable-tvhcsa \
                           --enable-trace \
                           --nowerror \
                           --disable-bintray_cache \
                           --python=$TOOLCHAIN/bin/python"

post_unpack() {
  sed -e 's/VER="0.0.0~unknown"/VER="'$PKG_VERSION_NUMBER' ~ LibreELEC Tvh-addon v'$ADDON_VERSION'.'$PKG_REV'"/g' -i $PKG_BUILD/support/version
  sed -e 's|'/usr/bin/pngquant'|'$TOOLCHAIN/bin/pngquant'|g' -i $PKG_BUILD/support/mkbundle
}

pre_configure_target() {
# pass ffmpegx to build
  PKG_CONFIG_PATH="$(get_build_dir ffmpegx)/.INSTALL_PKG/usr/local/lib/pkgconfig"
  CFLAGS="$CFLAGS -I$(get_build_dir ffmpegx)/.INSTALL_PKG/usr/local/include/"
  LDFLAGS="$LDFLAGS -L$(get_build_dir ffmpegx)/.INSTALL_PKG/usr/local/lib"

# fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

# transcoding
  if [ "$TARGET_ARCH" = x86_64 ]; then
    export AS="$TOOLCHAIN/bin/yasm"
    export LDFLAGS="$LDFLAGS -lX11 -lm -lvdpau -lva -lva-drm -lva-x11 -lbz2"
    export ARCH="$TARGET_ARCH"
  fi

  export CROSS_COMPILE="$TARGET_PREFIX"
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/iconv -L$SYSROOT_PREFIX/usr/lib/iconv"
}

# transcoding link tvheadend with g++
if [ "$TARGET_ARCH" = x86_64 ]; then
  pre_make_target() {
    export CXX="$CXX"
  }
fi

post_make_target() {
  $CC -O -fbuiltin -fomit-frame-pointer -fPIC -shared -o capmt_ca.so src/extra/capmt_ca.c -ldl
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/build.linux/tvheadend $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/capmt_ca.so $ADDON_BUILD/$PKG_ADDON_ID/bin
}
