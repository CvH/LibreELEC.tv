################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="aria2"
PKG_VERSION="1.32.0"
PKG_LICENSE="OpenSSL"
PKG_SITE="https://aria2.github.io/"
PKG_URL="https://github.com/aria2/$PKG_NAME/archive/release-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-release-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain libxml2 openssl sqlite zlib"
PKG_SHORTDESC="aria2: The next generation download utility"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"
