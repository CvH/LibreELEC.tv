# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="moonfin"
PKG_VERSION="2.7.0"
PKG_REV="2"
PKG_ARCH="x86_64 aarch64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/Moonfin-Client/Moonfin-Core"
case "${ARCH}" in
  "aarch64")
    PKG_SHA256="df74ed18378ec7409fdc3e114e35a9c3a471ee9e8efd552b48b007d24c272223"
    PKG_URL="https://github.com/Moonfin-Client/Moonfin-Core/releases/download/${PKG_VERSION}/Moonfin_LinuxARM64_v${PKG_VERSION}.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="6fa96531d9d4a93cb304f7c8775488e8b84d9bd2b383014da373d8d1e45d32e1"
    PKG_URL="https://github.com/Moonfin-Client/Moonfin-Core/releases/download/${PKG_VERSION}/Moonfin_Linux_v${PKG_VERSION}.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="moonfin-${PKG_VERSION}-${ARCH}.tar.gz"

PKG_DEPENDS_TARGET="toolchain mpv ffmpeg libsecret moonfin-gtk3 at-spi2-core atk cairo gdk-pixbuf harfbuzz-icu icu pango libepoxy wayland shared-mime-info"
PKG_SECTION="script"
PKG_SHORTDESC="Moonfin: Jellyfin and Emby Client"
PKG_LONGDESC="Moonfin is a modern, fast, and feature-rich Jellyfin and Emby media client built with Flutter."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Moonfin"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.externalhelper:0.0.0"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/resources"
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin"

  # Moonfin application bundle
  cp -PR "${PKG_BUILD}/"* "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/"
  chmod 755 "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/moonfin"
  chmod 755 "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/moonfin-bin"
  touch "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/.version_${PKG_VERSION}"

  # Build unified webview and GDK X11 stub plugin to avoid WebKit2GTK / GLX / X11 dependencies
  ${CC} -shared -fPIC -O2 \
    "${PKG_DIR}/source/src/libwebview_win_floating_plugin_stub.c" \
    -o "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libwebview_win_floating_plugin.so"

  # Remove bundled libraries from Moonfin release tarball that collide with LibreELEC builds or pull in desktop X11/GLX/WebKit
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libmpv"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libsecret"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libva"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libvdpau"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libSDL2"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libav"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libsw"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libpostproc"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libwebkit2gtk"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libjavascriptcoregtk"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libgstgl"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libX11"*
  rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/libGL"*

  # Launcher binary scripts
  cp -P "${PKG_DIR}/source/bin/moonfin-start" "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/"
  cp -P "${PKG_DIR}/source/bin/xdg-user-dir" "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/"
  chmod 755 "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/moonfin-start" "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/xdg-user-dir"

  # mpv (libmpv)
  cp -P $(get_install_dir mpv)/usr/lib/libmpv.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  patchelf --remove-needed libXfixes.so.3 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/libmpv.so"* 2>/dev/null || true
  patchelf --remove-needed libX11.so.6 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/libmpv.so"* 2>/dev/null || true

  # ffmpeg
  cp -P $(get_install_dir ffmpeg)/usr/lib/libav*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir ffmpeg)/usr/lib/libsw*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir ffmpeg)/usr/lib/libpostproc*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # libsecret
  cp -P $(get_install_dir libsecret)/usr/lib/libsecret-1.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # icu
  cp -P $(get_install_dir icu)/usr/lib/libicu*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # Wayland
  cp -L $(get_install_dir wayland)/usr/lib/libwayland-*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # GTK3 (with Wayland support from moonfin-gtk3) and display stack libraries
  cp -P $(get_install_dir moonfin-gtk3)/usr/lib/libgtk-3.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir moonfin-gtk3)/usr/lib/libgdk-3.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir atk)/usr/lib/libatk-1.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir at-spi2-core)/usr/lib/libatk-bridge-2.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir at-spi2-core)/usr/lib/libatspi.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir cairo)/usr/lib/libcairo.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir cairo)/usr/lib/libcairo-gobject.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir gdk-pixbuf)/usr/lib/libgdk_pixbuf-2.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir harfbuzz-icu)/usr/lib/libharfbuzz*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir pango)/usr/lib/libpango*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -P $(get_install_dir libepoxy)/usr/lib/libepoxy.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # Shared MIME database for gdk-pixbuf image format detection
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/share/mime/packages"
  cp -P $(get_install_dir shared-mime-info)/usr/share/mime/packages/freedesktop.org.xml \
    "${ADDON_BUILD}/${PKG_ADDON_ID}/share/mime/packages/"
  ${TOOLCHAIN}/bin/update-mime-database "${ADDON_BUILD}/${PKG_ADDON_ID}/share/mime"

  # In zip archives symlinks become duplicated full files. Reduce every library
  # chain in lib.private and moonfin/lib to a single regular file (its SONAME).
  for libdir in "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private" "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib"; do
    [ -d "${libdir}" ] || continue
    python3 -c "
import os, shutil
target_dir = '${libdir}'
links = []
for f in os.listdir(target_dir):
    p = os.path.join(target_dir, f)
    if os.path.islink(p):
        links.append((f, p, os.path.realpath(p)))

from collections import defaultdict
by_real = defaultdict(list)
for f, p, real in links:
    if os.path.dirname(real) == target_dir:
        by_real[real].append((f, p))

for real, symlinks in by_real.items():
    names = [f for f, p in symlinks]
    sonames = [n for n in names if any(n.endswith(f'.so.{d}') for d in range(100))]
    keep_name = sorted(sonames, key=lambda x: (len(x), x))[0] if sonames else sorted(names, key=lambda x: (len(x), x))[0]
    keep_path = os.path.join(target_dir, keep_name)
    for f, p in symlinks:
        if os.path.islink(p):
            os.unlink(p)
    if os.path.exists(real) and real != keep_path:
        shutil.move(real, keep_path)
"
  done

  # Remove any libraries from moonfin/lib that are already provided by LibreELEC in lib.private
  # Preserve ICU 70 which is required by bundled libxml2/libarchive
  for f in "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"*.so*; do
    [ -e "${f}" ] || continue
    name="$(basename "${f}")"
    base="${name%%.so*}.so"
    case "${base}" in
      libicu*|libwebview*) continue ;;
    esac
    rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/${name}"*
    rm -f "${ADDON_BUILD}/${PKG_ADDON_ID}/moonfin/lib/${base}"*
  done
}

post_install_addon() {
  sed -e "s/@PKG_VERSION@/${PKG_VERSION}/g" -i "${INSTALL}/default.py"
}
