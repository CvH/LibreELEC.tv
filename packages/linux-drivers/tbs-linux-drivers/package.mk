################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tbs-linux-drivers"
PKG_VERSION="160126"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tbsdtv.com/english/Download.html"
PKG_URL="http://www.tbsdtv.com/download/document/common/tbs-linux-drivers_v${PKG_VERSION}.zip"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Linux TBS tuner drivers"
PKG_LONGDESC="Linux TBS tuner drivers"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  tar xjf $ROOT/$PKG_BUILD/linux-tbs-drivers.tar.bz2 -C $ROOT/$PKG_BUILD
  chmod -R u+rwX $ROOT/$PKG_BUILD/linux-tbs-drivers/*
}

make_target() {
  cd $ROOT/$PKG_BUILD/linux-tbs-drivers
  ./v4l/tbs-x86_64.sh
  LDFLAGS="" make DIR=$(kernel_path) prepare
  LDFLAGS="" make DIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/updates/tbs
  find $ROOT/$PKG_BUILD/linux-tbs-drivers/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$(get_module_dir)/updates/tbs \;
  mkdir -p $INSTALL/lib/firmware/
  cp $ROOT/$PKG_BUILD/*.fw $INSTALL/lib/firmware/
}


pre_install() {
  # modules are installed under this name
  KNAME_THIS=$PKG_NAME
  # compare with
  KNAME_CMP=sys

  KVER=$(get_module_dir)
  KDIR_ROOT=$INSTALL/lib/modules/${KVER}
  KDIR_SYS=$INSTALL/lib/modules/${KVER}-sys
  KDIR_THIS=$INSTALL/lib/modules/${KVER}-$KNAME_THIS
  KDIR_CMP=$INSTALL/lib/modules/${KVER}-$KNAME_CMP
  echo "$KDIR_ROOT" "$KDIR_SYS"

  if [ -d "$KDIR_SYS" ]; then
    echo "folder $KDIR_SYS must not exist"
    exit 1
  fi

  cp -aP "$KDIR_ROOT" "$KDIR_SYS"
}

post_install() {
  find $KDIR_ROOT/* -type f -name *.ko | while read f1; do
    f2=$(echo "$f1" | sed "s|$KDIR_ROOT/||")

    if [ -f $KDIR_ROOT/$f2 -a -f $KDIR_CMP/$f2 ]; then
      md5_new=$(md5sum $KDIR_ROOT/$f2 | cut -d ' ' -f1)
      md5_cmp=$(md5sum $KDIR_CMP/$f2 | cut -d ' ' -f1)
      if [ "$md5_new" = "$md5_cmp" ]; then
        # use hard link from compared kernel
        ln -f "$KDIR_CMP/$f2" "$KDIR_ROOT/$f2"
      fi
    fi

    # todo: check if there can be symbolic link for module file
  done

  # run depmod
  MODVER=${KVER}

  find $INSTALL/lib/modules/$MODVER/ -name *.ko | \
    sed -e "s,$INSTALL/lib/modules/$MODVER/,," > $INSTALL/lib/modules/$MODVER/modules.order
  $ROOT/$TOOLCHAIN/bin/depmod -b $INSTALL $MODVER 2>/dev/null

  # strip kernel modules
  for MOD in $(find $INSTALL/lib/modules/$MODVER -type f -name *.ko); do
    $STRIP --strip-debug $MOD || : # ignore
  done

  # rename to new folder
  rm -fr "$KDIR_THIS"
  mv "$KDIR_ROOT" "$KDIR_THIS"

  # rename sys folder back
  mv "$KDIR_SYS" "$KDIR_ROOT"

  echo "${KVER}-$KNAME_THIS" >>$INSTALL/lib/modules/.kernel_modules_dir
}
