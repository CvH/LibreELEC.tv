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
import tools

addon       = xbmcaddon.Addon(id='script.picons')
addonname   = addon.getAddonInfo('name')
addonfolder = addon.getAddonInfo('path')
addonicon   = os.path.join(addonfolder, 'resources/icon.png')
addondata   = xbmc.translatePath(addon.getAddonInfo('profile'))
snp_json    = os.path.join(addondata, 'data/snp.json')
srp_json    = os.path.join(addondata, 'data/srp.json')
url_latest  = 'http://cvh.libreelec.tv/picons/latest.json'
latest_json = urllib.urlopen(url_latest)

srp_path    = os.path.join('/storage/picons/tvh')
snp_path    = os.path.join('/storage/picons/vdr')

log3rdparty = os.path.join(addondata, 'data/3rdparty.log')
logjson     = os.path.join(addondata, 'data/release.json')

exturl      = addon.getSetting('exturl')
dialog      = xbmcgui.Dialog()

def compare_release_snp(path):
    ljson = json.loads(latest_json.read())
    for key in ljson['Picons']['latest'].keys():
        latest = key
    with open(snp_json) as release_json:
        rjson = json.load(release_json)
    for key1 in rjson['Picons']['latest'].keys():
        release = key1
    if latest == release:
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, 'Already latest version, same version', 2000, addonicon))
    else:
        tools.delete_directories(path)
        urlpicons = ljson['Picons']['url']
        snpname   = ljson['Picons']['latest'][latest]['snp']['name']
        url = "%s%s" % (urlpicons, snpname)
        tools.picons_snp(url, url_latest)
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, '"Download finished"', 2000, addonicon))

def compare_release_srp(path):
    ljson = json.loads(latest_json.read())
    for key in ljson['Picons']['latest'].keys():
        latest = key
    with open(srp_json) as release_json:
        rjson = json.load(release_json)
    for key1 in rjson['Picons']['latest'].keys():
        release = key1
    if latest == release:
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, 'Already latest version, same version', 2000, addonicon))
    else:
        tools.delete_directories(path)
        urlpicons = ljson['Picons']['url']
        srpname   = ljson['Picons']['latest'][latest]['srp']['name']
        url = "%s%s" % (urlpicons, srpname)
        tools.picons_srp(url, url_latest)
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, '"Download finished"', 2000, addonicon))

def url_snp():
    ljson = json.loads(latest_json.read())
    for key in ljson['Picons']['latest'].keys():
        latest = key
    urlpicons = ljson['Picons']['url']
    snpname   = ljson['Picons']['latest'][latest]['snp']['name']
    url = "%s%s" % (urlpicons, snpname)
    tools.picons_snp(url, url_latest)
    xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, '"Download the picons is finish"', 2000, addonicon))

def url_srp():
    ljson = json.loads(latest_json.read())
    for key in ljson['Picons']['latest'].keys():
        latest = key
    urlpicons = ljson['Picons']['url']
    srpname   = ljson['Picons']['latest'][latest]['srp']['name']
    url = "%s%s" % (urlpicons, srpname)
    tools.picons_srp(url, url_latest)
    xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, '"Download the picons is finish"', 2000, addonicon))

def url_external():
    if addon.getSetting('pathpicons') == '':
        xbmcgui.Dialog().ok(addonname, "You need choose destination for picons", "", "")
        xbmc.executebuiltin('Addon.OpenSettings(script.picons)')
    elif addon.getSetting('exturl') == '':
        xbmcgui.Dialog().ok(addonname, "You need choose the external url", "", "")
        xbmc.executebuiltin('Addon.OpenSettings(script.picons)')
    else:
        tools.picons_ext(exturl)
        xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(addonname, '"Download the picons is finish"', 2000, addonicon))

try:
    args = ' '.join(sys.argv[1:])
except:
    args = ""

if args == 'srp':
    if os.path.exists(srp_json):
        compare_release_srp(srp_path)
    else:
        url_srp()

elif args == 'snp':
    if os.path.exists(snp_json):
        compare_release_snp(snp_path)
    else:
        url_snp()

else:
    if addon.getSetting('urldown') == 'true':
        if os.path.exists(log3rdparty):
            thirdpart = dialog.yesno(addonname, "The picons have already been downloaded", "Settings: Open addon Settings","Download again picons","Settings", "Download")
            if thirdpart == 0:
                xbmc.executebuiltin('Addon.OpenSettings(script.picons)')
            if thirdpart == 1:
                url_external()
        else:
            url_external()
    else:
        xbmc.executebuiltin('Addon.OpenSettings(script.picons)')
