# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openssl-compat"
PKG_VERSION="1.1.1m"
PKG_SHA256="f89199be8b23ca45fc7cb9f1d8d3ee67312318286ad030f5316aca6462db6c96"
PKG_LICENSE="BSD"
PKG_SITE="https://www.openssl.org"
PKG_URL="https://www.openssl.org/source/openssl-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The Open Source toolkit for Secure Sockets Layer and Transport Layer Security"
PKG_TOOLCHAIN="configure"

PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_SHARED="--libdir=lib \
                           shared \
                           threads \
                           no-ec2m \
                           no-md2 \
                           no-rc5 \
                           no-rfc3779 \
                           no-sctp \
                           no-ssl-trace \
                           no-ssl3 \
                           no-unit-test \
                           no-weak-ssl-ciphers \
                           no-zlib \
                           no-zlib-dynamic \
                           no-static-engine"

pre_configure_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -a ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}/

  case ${TARGET_ARCH} in
    x86_64)
      OPENSSL_TARGET=linux-x86_64
      PLATFORM_FLAGS=enable-ec_nistp_64_gcc_128
      ;;
    arm)
      OPENSSL_TARGET=linux-armv4
      ;;
    aarch64)
      OPENSSL_TARGET=linux-aarch64
      ;;
  esac
}

configure_target() {
  cd ${PKG_BUILD}/.${TARGET_NAME}
  ./Configure ${PKG_CONFIGURE_OPTS_TARGET} ${PKG_CONFIGURE_OPTS_SHARED} ${PLATFORM_FLAGS} ${OPENSSL_TARGET} ${CFLAGS} ${LDFLAGS}
}
