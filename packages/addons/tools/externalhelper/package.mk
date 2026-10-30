# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="externalhelper"
PKG_VERSION="0"
PKG_REV="12"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain seatd wayland kanshi wayvnc hyprland"
PKG_SECTION="tools"
PKG_SHORTDESC="External programs helper"
PKG_LONGDESC="Tools to run external programs in a minimal wayland session"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="External programs helper"
PKG_ADDON_ICON_NAME="HELPER"
PKG_ADDON_ICON_SIZE="250"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir seatd)/usr/bin/{seatd,seatd-launch} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir hyprland)/usr/bin/{Hyprland,hyprctl} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir kanshi)/usr/bin/kanshi "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir wayvnc)/usr/bin/wayvnc "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"

    for f in seatd seatd-launch Hyprland hyprctl kanshi wayvnc; do
      patchelf --add-rpath '${ORIGIN}/../lib.private' "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/${f}"
    done

  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir aml)/usr/lib/libaml.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir jansson)/usr/lib/libjansson.so.4 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir seatd)/usr/lib/libseat.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir wayland)/usr/lib/libwayland-{client,server}.so.0 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir aquamarine)/usr/lib/libaquamarine.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir hyprutils)/usr/lib/libhyprutils.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir hyprlang)/usr/lib/libhyprlang.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir hyprcursor)/usr/lib/libhyprcursor.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir hyprgraphics)/usr/lib/libhyprgraphics.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir hyprwire)/usr/lib/libhyprwire.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir lua55)/usr/lib/liblua5.5.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir re2)/usr/lib/libre2.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir muparser)/usr/lib/libmuparser.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libeis)/usr/lib/libei*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir tomlplusplus)/usr/lib/libtomlplusplus.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libzip)/usr/lib/libzip.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libdisplay-info)/usr/lib/libdisplay-info.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libXcursor)/usr/lib/libXcursor.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libX11)/usr/lib/libX11.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libXfixes)/usr/lib/libXfixes.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libXrender)/usr/lib/libXrender.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir libxcb)/usr/lib/libxcb.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir file)/usr/lib/libmagic.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir glslang)/usr/lib/libglslang.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir glslang)/usr/lib/libSPIRV.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

    for f in "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"*.so*; do
      [ -f "${f}" ] || continue
      [ -h "${f}" ] && continue
      patchelf --set-rpath '${ORIGIN}' "${f}" 2>/dev/null || true
    done

  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/config"
    cp -P "${PKG_DIR}/source/config/hyprland-kiosk.lua" "${ADDON_BUILD}/${PKG_ADDON_ID}/config/"
}
