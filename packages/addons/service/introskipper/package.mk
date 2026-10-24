# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="introskipper"
PKG_VERSION="cd6b8f700d3f69bbc40378592b583346282d439c"
PKG_SHA256="ea290284e15b335f19375d7ba8b6d315ffe8b89a48baeb9bbb1b1e82a135c4b8"
PKG_REV="1"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/CvH/kodi-intro-skipper"
PKG_URL="https://github.com/CvH/kodi-intro-skipper/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Intro Skipper: Standalone intro and credit detection daemon and Kodi add-on"
PKG_LONGDESC="Intro Skipper detects and skips introduction and ending credits in TV shows."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-strip"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Intro Skipper"
PKG_ADDON_ICON_NAME="none"
PKG_ADDON_ICON_SIZE="340"
PKG_ADDON_ICON_OFFSET='+2'
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.dotnet-runtime:0.0.0"

make_target() {
  local rid

  case "${TARGET_ARCH}" in
    x86_64)  rid="linux-x64" ;;
    aarch64) rid="linux-arm64" ;;
    arm)     rid="linux-arm" ;;
    *)       die "Unsupported architecture: ${TARGET_ARCH}" ;;
  esac

  dotnet publish IntroSkipper.Server/IntroSkipper.Server.csproj \
    -c Release \
    -r "${rid}" \
    --no-self-contained \
    -p:PublishSingleFile=true \
    -p:EnableCompressionInSingleFile=false \
    -p:IncludeNativeLibrariesForSelfExtract=true \
    -p:DebugType=none \
    -p:DebugSymbols=false \
    -p:IncludeSymbolsInSingleFile=false \
    -p:SkipTests=true \
    -p:IsTestProject=false \
    -o ${PKG_BUILD}/.publish

  rm -f ${PKG_BUILD}/.publish/*.pdb ${PKG_BUILD}/.publish/*.xml ${PKG_BUILD}/.publish/*.endpoints.json
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  # Kodi companion addon files
  cp -PR ${PKG_BUILD}/kodi-addon/service.introskipper/* ${ADDON_BUILD}/${PKG_ADDON_ID}/

  # Addon dependencies (ffmpeg-tools and dotnet-runtime)
  sed -i 's|<import addon="xbmc.python" version="3.0.0"/>|&\n    <import addon="tools.ffmpeg-tools" version="0.0.0"/>\n    <import addon="tools.dotnet-runtime" version="0.0.0"/>|' \
    ${ADDON_BUILD}/${PKG_ADDON_ID}/addon.xml

  # IntroSkipper Server published binaries/assemblies
  cp -PR ${PKG_BUILD}/.publish/* ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
  chmod +x ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/IntroSkipper.Server
}

