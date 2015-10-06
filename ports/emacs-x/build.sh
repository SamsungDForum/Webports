# Copyright (c) 2014 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

BuildStep() {
  # Meta package, no build.
  return
}

InstallStep() {
  local ASSEMBLY_DIR=${PUBLISH_DIR}/app
  MakeDir ${ASSEMBLY_DIR}

  local EMACS_PORT_DIR=${START_DIR}/../emacs
  local EMACS_DIR=${NACL_PACKAGES_PUBLISH}/emacs/${TOOLCHAIN}/emacs
  local XORG_DIR=${NACL_PACKAGES_PUBLISH}/xorg-server/${TOOLCHAIN}/xorg-server

  LogExecute cp ${EMACS_DIR}/*.nmf ${ASSEMBLY_DIR}/
  LogExecute cp ${EMACS_DIR}/*.nexe ${ASSEMBLY_DIR}/
  if [[ ${NACL_SHARED} == 1 ]]; then
    LogExecute cp -r ${EMACS_DIR}/lib* ${ASSEMBLY_DIR}/
  fi
  LogExecute cp ${EMACS_DIR}/*.tar ${ASSEMBLY_DIR}/
  LogExecute cp ${EMACS_DIR}/*.png ${ASSEMBLY_DIR}/

  LogExecute cp -r ${XORG_DIR}/_platform_specific ${ASSEMBLY_DIR}/
  LogExecute cp ${XORG_DIR}/*.nmf ${ASSEMBLY_DIR}/
  LogExecute cp ${XORG_DIR}/*.nexe ${ASSEMBLY_DIR}/
  if [[ ${NACL_SHARED} == 1 ]]; then
    LogExecute cp -r ${XORG_DIR}/lib* ${ASSEMBLY_DIR}/
  fi
  LogExecute cp ${XORG_DIR}/*.tar ${ASSEMBLY_DIR}/
  LogExecute cp ${XORG_DIR}/*.js ${ASSEMBLY_DIR}/
  LogExecute cp ${XORG_DIR}/*.html ${ASSEMBLY_DIR}/

  LogExecute cp ${START_DIR}/Xsdl.js ${ASSEMBLY_DIR}/

  LogExecute python ${TOOLS_DIR}/create_term.py -n EmacsXWindows emacs.nmf
  GenerateManifest ${EMACS_PORT_DIR}/manifest.json ${ASSEMBLY_DIR} \
    "TITLE"="EmacsXWindows"
}
