# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flatpak.spotify"
PKG_VERSION="0"
PKG_REV="0"
PKG_ARCH="x86_64"
PKG_LICENSE="Custom"
PKG_SITE="https://www.spotify.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Spotify music player"
PKG_LONGDESC="This is the flatpak version of Spotify.\nUse the Flatpak addon to update it."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Spotify"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.flatpak:0.0.0"

addon() {
  :
}
