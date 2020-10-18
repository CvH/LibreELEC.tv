# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyperion-ng"
PKG_VERSION="a0311bd8b58dd12aec0bdd62e1ec47adcaa340f4"
PKG_SHA256="108c21e235243329e725a5dbf2a3ed79f026f1b3731f2c6c9e2685a8bb289550"
PKG_VERSION_DATE="2020-11-17"
PKG_REV="100"
PKG_ARCH="x86_64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/hyperion-project/hyperion.ng"
PKG_URL="https://github.com/hyperion-project/hyperion.ng/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 libusb qtbase protobuf avahi flatbuffers flatbuffers:host libcec qtserialport"
PKG_SECTION="service"
PKG_SHORTDESC="Hyperion.NG: an AmbiLight controller"
PKG_LONGDESC="Hyperion.NG (${PKG_VERSION_DATE}) is a modern opensource AmbiLight implementation."
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion.NG"
PKG_ADDON_TYPE="xbmc.service"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" xorg-server xrandr xcb-util"
  PKG_X11_SUPPORT="-DENABLE_X11=ON -DENABLE_FB=OFF -DPLATFORM=x86"
fi

pre_configure_target() {
  # workaround to define variable for patch
  # src/hyperiond/hyperiond.cpp
  export ENABLE_LE=1
}

PKG_CMAKE_OPTS_TARGET="-DPython3_EXECUTABLE=${TOOLCHAIN}/bin/${PKG_PYTHON_VERSION} \
                       -DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DENABLE_AMLOGIC=OFF \
                       -DENABLE_OSX=OFF \
                       -DUSE_SYSTEM_PROTO_LIBS=ON \
                       -DUSE_SYSTEM_FLATBUFFERS_LIBS=ON \
                       -DENABLE_SPIDEV=OFF \
                       -DENABLE_TINKERFORGE=OFF \
                       -DENABLE_V4L2=ON \
                       -DENABLE_WS281XPWM=OFF \
                       ${PKG_X11_SUPPORT} \
                       -DENABLE_TESTS=OFF \
                       -Wno-dev \
                       -DQT_BIN_PATH=${TOOLCHAIN}/bin"

addon() {
  mkdir -p $ADDON_BUILD/${PKG_ADDON_ID}/bin
    cp ${PKG_INSTALL}/usr/bin/* ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  cp -PR ${PKG_INSTALL}/usr/share/hyperion/effects ${ADDON_BUILD}/${PKG_ADDON_ID}

  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/lib"
    cp "$(get_build_dir avahi)/avahi-compat-libdns_sd/.libs/libdns_sd.so.1" \
       "$ADDON_BUILD/$PKG_ADDON_ID/lib"
}
