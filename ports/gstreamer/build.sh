# Copyright (c) 2017 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EXECUTABLES="
  tools/gst-launch-1.0${NACL_EXEEXT}
  tools/gst-typefind-1.0${NACL_EXEEXT}
  tools/gst-inspect-1.0${NACL_EXEEXT}
  tools/gst-stats-1.0${NACL_EXEEXT}
"

EnableGlibcCompat

ConfigureStep() {
  SetupCrossEnvironment

  export ac_cv_func_issetugid=no
  export ac_cv_func_pselect=no
  export ac_cv_func_getrusage=no

  local lib_type=""
  if [ "${NACL_ARCH}" = "pnacl" ]; then
    lib_type=" --enable-static --disable-shared"
  else
    lib_type=" --disable-static --enable-shared"
  fi

  LogExecute ${SRC_DIR}/configure \
    --host=nacl \
    --prefix=${PREFIX} \
    --disable-registry \
    --enable-static-plugins \
    --disable-examples \
    --disable-tests \
    --disable-benchmarks \
    ${lib_type}
}
