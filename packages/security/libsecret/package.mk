# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libsecret"
PKG_VERSION="0.21.7"
PKG_SHA256="6b452e4750590a2b5617adc40026f28d2f4903de15f1250e1d1c40bfd68ed55e"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://wiki.gnome.org/Projects/Libsecret"
PKG_URL="https://download.gnome.org/sources/${PKG_NAME}/$(get_pkg_version_maj_min)/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libgcrypt"
PKG_SECTION="security"
PKG_SHORTDESC="Library for storing and retrieving passwords and other secrets"
PKG_LONGDESC="libsecret is a library for storing and retrieving passwords and other secrets."

PKG_MESON_OPTS_TARGET="-Dmanpage=false \
                       -Dgtk_doc=false \
                       -Dintrospection=false \
                       -Dvapi=false \
                       -Dbash_completion=disabled \
                       -Dcrypto=libgcrypt \
                       -Dtpm2=false"
