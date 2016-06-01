#!/bin/bash

if [ "${NACL_LIBC}" = "newlib" ]; then
  EXTRA_CMAKE_ARGS+=" -DEXTRA_INCLUDE=${NACLPORTS_INCLUDE}/glibc-compat"
fi

ConfigureStep() {
  SetupCrossEnvironment
  DefaultConfigureStep
}
