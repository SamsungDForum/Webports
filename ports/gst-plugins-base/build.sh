# Copyright (c) 2017 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EXECUTABLES="
  tools/gst-device-monitor-1.0${NACL_EXEEXT}
  tools/gst-discoverer-1.0${NACL_EXEEXT}
  tools/gst-play-1.0${NACL_EXEEXT}
"

EnableGlibcCompat

ConfigureStep() {
  local extra_args=""
  if [ "${NACL_ARCH}" = "arm" ]; then
    NACLPORTS_CFLAGS+=" -fPIC"
    NACLPORTS_CFLAGS+=" -Wno-declaration-after-statement"
    extra_args+=" --disable-tcp"
  fi

  SetupCrossEnvironment

  local lib_type=""
  if [ "${NACL_ARCH}" = "pnacl" ]; then
    lib_type=" --enable-static --disable-shared"
  else
    lib_type=" --disable-static --enable-shared"
  fi

  LogExecute ${SRC_DIR}/configure \
    --host=nacl \
    --prefix=${PREFIX} \
    --enable-static-plugins \
    --disable-examples \
    --disable-orc \
    --disable-external \
    --disable-x \
    --disable-xshm \
    --disable-alsa \
    --disable-cdparanoia \
    --disable-libvisual \
    ${lib_type} \
    ${extra_args}
}
