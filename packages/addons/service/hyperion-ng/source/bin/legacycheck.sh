#!/bin/bash

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

if (systemctl is-active --quiet hyperion.service); then
  systemctl stop hyperion.service
  systemctl disable hyperion.service
fi
