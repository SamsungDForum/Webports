# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EnableGlibcCompat

BuildStep() {
  SetupCrossEnvironment
  export LD=${NACLCXX}
  export PATH=${NACL_BIN_PATH}:${PATH}

  LogExecute make -f ${SRC_DIR}/Makefile -j${OS_JOBS}
}

InstallStep() {
  SetupCrossEnvironment
  INSTALL_TARGETS=${INSTALL_TARGETS:-install}
  export PATH=${NACL_BIN_PATH}:${PATH}

  LogExecute make -f ${SRC_DIR}/Makefile ${INSTALL_TARGETS} "DESTDIR=${DESTDIR}/${PREFIX}"
}
