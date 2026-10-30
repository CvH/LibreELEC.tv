# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="attrs"
PKG_VERSION="26.1.0"
PKG_SHA256="d03ceb89cb322a8fd706d4fb91940737b6642aa36998fe130a9bc96c985eff32"
PKG_LICENSE="MIT"
PKG_SITE="https://www.attrs.org/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host hatchling:host hatch-vcs:host"
PKG_LONGDESC="Classes Without Boilerplate"
PKG_TOOLCHAIN="python"

pre_configure_host() {
  sed -i \
      -e 's/dynamic = \["version", "readme"\]/dynamic = \["version"\]\nreadme = "README.md"/' \
      -e '/\[tool.hatch.metadata.hooks.fancy-pypi-readme\]/,$d' \
      pyproject.toml
}
