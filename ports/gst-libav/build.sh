# Copyright (c) 2017 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EnableGlibcCompat

ConfigureStep() {
  SetupCrossEnvironment

  local lib_type=""
  if [ "${NACL_ARCH}" = "pnacl" ]; then
    lib_type=" --enable-static --disable-shared"
  else
    lib_type=" --disable-static --enable-shared"
  fi

  export CFLAGS="${NACLPORTS_CFLAGS} -Wno-deprecated-declarations"
  LogExecute ${SRC_DIR}/configure \
    --host=nacl \
    --prefix=${PREFIX} \
    --enable-static-plugins \
    --with-system-libav \
    ${lib_type}
}
