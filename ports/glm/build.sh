#!/bin/bash

if [ "${NACL_ARCH}" = "pnacl" ]; then
  EnableGlibcCompat
fi

ConfigureStep() {
  SetupCrossEnvironment
  DefaultConfigureStep
}
