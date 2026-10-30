-- SPDX-License-Identifier: GPL-2.0-or-later
-- Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)
-- Hyprland Kiosk Configuration for externalhelper

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        shadow = { enabled = false },
        blur = { enabled = false },
    },
    animations = {
        enabled = false,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = 0x000000,
    },
    input = {
        kb_layout = os.getenv("XKB_DEFAULT_LAYOUT") or "us",
        follow_mouse = 1,
    },
})

-- Force all windows into fullscreen kiosk presentation
hl.window_rule({
    name = "kiosk-fullscreen",
    match = { class = ".*" },
    fullscreen = true,
})

-- Emergency exit hotkey: Ctrl + Alt + Backspace
hl.bind("CTRL + ALT + BackSpace", hl.dsp.exit())

-- Auto-launch runner when compositor is ready
hl.on("hyprland.start", function ()
    local runner = os.getenv("EXTERNALHELPER_RUNNER")
    if runner and runner ~= "" then
        hl.exec_cmd(runner)
    end
end)

