/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv) */

#include <stdint.h>

/*
 * Stub implementation of the webview_win_floating Flutter plugin.
 * Moonfin does not require an embedded webview for standard Jellyfin/Emby usage,
 * and replacing the plugin avoids dragging in WebKit2GTK, JavaScriptCore, and GLX.
 */

void webview_win_floating_plugin_register_with_registrar(void *registrar) {
  (void)registrar;
}

uint64_t webview_win_floating_plugin_get_type(void) {
  return 1;
}

/*
 * GDK X11 stub symbols.
 * The Flutter Linux engine (libflutter_linux_gtk.so) dynamically checks for X11 vs Wayland
 * by calling gdk_x11_* functions. Because moonfin-gtk3 is built pure Wayland (-Dx11_backend=false),
 * these stubs ensure Flutter cleanly takes the Wayland path without runtime link errors.
 */

uint64_t gdk_x11_screen_get_type(void) {
  return 0;
}

const char *gdk_x11_screen_get_window_manager_name(void *screen) {
  (void)screen;
  return "cage";
}

uint64_t gdk_x11_display_get_type(void) {
  return 0;
}

void *gdk_x11_display_get_xdisplay(void *display) {
  (void)display;
  return 0;
}

uint64_t gdk_x11_cursor_get_xcursor(void *cursor) {
  (void)cursor;
  return 0;
}

uint64_t gdk_x11_window_get_xid(void *window) {
  (void)window;
  return 0;
}
