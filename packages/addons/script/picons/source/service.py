#!/usr/bin/env python
################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-2017 Team LibreELEC
#      Copyright (C) 2017 Tnds82 (tndsrepo@gmail.com)
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

import os, xbmc, xbmcaddon, xbmcgui, json, urllib

xbmc.sleep(5000)

addon       = xbmcaddon.Addon(id='script.picons')
addonname   = addon.getAddonInfo('name')
addonfolder = addon.getAddonInfo('path')
addonicon   = os.path.join(addonfolder, 'resources/icon.png')
addondata   = xbmc.translatePath(addon.getAddonInfo('profile'))
snp_json    = os.path.join(addondata, 'data/snp.json')
srp_json    = os.path.join(addondata, 'data/srp.json')
url_latest  = 'http://cvh.libreelec.tv/picons/latest.json'
latest_json = urllib.urlopen(url_latest)

dialog = xbmcgui.Dialog()

def compare_releases(path):
    ljson = json.loads(latest_json.read())
    for key in ljson['Picons']['latest'].keys():
        latest = key
    with open(path) as release_json:
        rjson = json.load(release_json)
    for key1 in rjson['Picons']['latest'].keys():
        release = key1
    if latest == release:
        pass
    else:
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, "New Release of Picons", 6000, addonicon))

if os.path.exists(snp_json):
    compare_releases(snp_json)
elif os.path.exists(srp_json):
    compare_releases(srp_json)
else:
    pass
