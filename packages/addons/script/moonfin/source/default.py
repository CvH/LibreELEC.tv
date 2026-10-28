# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import os
import platform
import subprocess
import tarfile
from urllib.request import urlopen
from tempfile import TemporaryDirectory

import externalhelper.utils as eh
import xbmc
import xbmcaddon
import xbmcgui

ADDON = xbmcaddon.Addon()
ADDON_DIR = ADDON.getAddonInfo('path')
ADDON_NAME = ADDON.getAddonInfo('name')
LAUNCHER = os.path.join(ADDON_DIR, 'bin', 'moonfin-start')
VERSION = "@PKG_VERSION@"


def get_platform_tag():
    machine = platform.machine().lower()
    if machine in ('x86_64', 'amd64'):
        return 'Linux'
    elif machine in ('aarch64', 'arm64'):
        return 'LinuxARM64'
    return None


def download_and_extract(url: str, dest_dir: str) -> bool:
    dialog = xbmcgui.DialogProgress()
    dialog.create(ADDON_NAME, 'Downloading Moonfin...')
    try:
        with urlopen(url) as response:
            total_size = int(response.headers.get('content-length', 0))
            downloaded = 0
            with TemporaryDirectory() as tmp_dir:
                tar_path = os.path.join(tmp_dir, 'moonfin.tar.gz')
                with open(tar_path, 'wb') as f:
                    while True:
                        chunk = response.read(65536)
                        if not chunk:
                            break
                        f.write(chunk)
                        downloaded += len(chunk)
                        if total_size > 0:
                            percent = int(downloaded * 100 / total_size)
                            dialog.update(percent, f'Downloading Moonfin ({percent}%)...')
                        if dialog.iscanceled():
                            return False

                dialog.update(100, 'Extracting Moonfin bundle...')
                os.makedirs(dest_dir, exist_ok=True)
                with tarfile.open(tar_path, 'r:*') as tar:
                    tar.extractall(dest_dir)
        return True
    except Exception as e:
        xbmc.log(f'Moonfin download/extract failed: {e}', xbmc.LOGERROR)
        xbmcgui.Dialog().ok(ADDON_NAME, f'Failed to install Moonfin:\n{e}')
        return False
    finally:
        dialog.close()


def main():
    platform_tag = get_platform_tag()
    if not platform_tag:
        xbmcgui.Dialog().ok(ADDON_NAME, f'Unsupported CPU architecture: {platform.machine()}')
        return

    moonfin_dir = os.path.join(ADDON_DIR, 'moonfin')
    moonfin_binary = os.path.join(moonfin_dir, 'moonfin')
    version_stamp = os.path.join(moonfin_dir, f'.version_{VERSION}')

    # Download pre-built bundle if not already bundled or up to date
    if not os.path.isfile(moonfin_binary) or not os.path.isfile(version_stamp):
        url = f"https://github.com/Moonfin-Client/Moonfin-Core/releases/download/{VERSION}/Moonfin_{platform_tag}_v{VERSION}.tar.gz"
        success = download_and_extract(url, moonfin_dir)
        if not success:
            return

        if os.path.isfile(moonfin_binary):
            os.chmod(moonfin_binary, 0o755)
        binary_alt = os.path.join(moonfin_dir, 'moonfin-bin')
        if os.path.isfile(binary_alt):
            os.chmod(binary_alt, 0o755)

        with open(version_stamp, 'w') as f:
            f.write(VERSION)

    os.chmod(LAUNCHER, 0o755)
    for b in ('moonfin', 'moonfin-bin'):
        bp = os.path.join(moonfin_dir, b)
        if os.path.isfile(bp):
            try:
                os.chmod(bp, 0o755)
            except Exception:
                pass

    try:
        custom_args = ADDON.getSettingString('custom_args')
    except Exception:
        custom_args = ''
    args = []
    if custom_args and custom_args.strip():
        args = custom_args.strip().split()

    # Launch Moonfin inside cage Wayland kiosk session
    eh.run_external_program(executable=LAUNCHER, args=args, name=ADDON_NAME, wayland=True)


if __name__ == '__main__':
    main()
