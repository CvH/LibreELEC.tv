# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="voice2json"
PKG_VERSION="2.1"
PKG_SHA256="347d6a82ec22d7406cbdc207958006bba2012a9e7a2d205571d5122c8904664d"
PKG_LICENSE="MIT"
PKG_SITE="http://voice2json.org"
PKG_URL="https://github.com/synesthesiam/voice2json/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 portaudio"
PKG_LONGDESC="Is a collection of command-line tools for offline speech/intent recognition."

export VOICE2JSON_SPEECH_SYSTEM="deepspeech"
export VOICE2JSON_LANGUAGE="en"

PKG_CONFIGURE_OPTS_TARGET="--disable-precompiled-binaries \
                           --disable-opengrm \
                           --disable-virtualenv \
                           --disable-phonetisaurus \
                           --disable-pocketsphinx \
                           --disable-kaldi \
                           --disable-julius \
                           --disable-training"

