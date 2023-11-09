#!/bin/bash

oe_setup_addon service.tvheadend43

ICON="$ADDON_DIR/resources/icon.png"

# send kodi messages
function_notification() {
  kodi-send --action="Notification(${1},${2},${ICON})" >/dev/null
  #  python - << EOF
  #import xbmc, xbmcvfs, xbmcgui, xbmcaddon
  #xbmcgui.Dialog().notification('Movie Trailers', 'Finding Nemo download finished.', xbmcgui.NOTIFICATION_INFO, 3000)
  #EOF
}

# download
function_download() {
  LATEST_VERSION=$(curl -sS https://linuxtv.org/downloads/dtv-scan-tables/ | grep "dtv-scan-tables-LATEST.tar.bz2" | grep -oE "[0-9-]{10}")
  TMP_DIR=$(mktemp -d)
  function_notification "Download and install Scan-Tables ${LATEST_VERSION}" "2000"
  curl -sS -L "https://linuxtv.org/downloads/dtv-scan-tables/dtv-scan-tables-LATEST.tar.bz2" -o "${TMP_DIR}/dtv-scan-tables.bz2"
}

# exctract
function_extract() {
  function_notification "Extract Scan-Tables" "1000"
  rm -rf "$ADDON_DIR/dvb-scan/*"
  tar xf "${TMP_DIR}/dtv-scan-tables.bz2" --strip-components=3 -C "$ADDON_DIR/dvb-scan"
  touch "$ADDON_DIR/dvb-scan/release_${LATEST_VERSION}"
}

if ! function_download; then
  function_notification "Could not download Scan-Tables" "15000"
  exit 0
fi

if function_extract; then
  function_notification "Download completed, tables installed" "1000"
else
  function_notification "Could not extract zip files" "15000"
  exit 0
fi
