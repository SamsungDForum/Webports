# Copyright (c) 2013 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

export ac_cv_func_gethostbyname=yes
export ac_cv_func_getaddrinfo=no
export ac_cv_func_connect=yes

# Can't use LIBS here otherwise nacl-spawn gets linked into the libcurl.so
# which we don't ever want.
export EXTRA_LIBS="${NACL_CLI_MAIN_LIB}"
NACLPORTS_LDFLAGS+=" ${NACL_CLI_MAIN_LDFLAGS}"

EnableGlibcCompat

EXTRA_CONFIGURE_ARGS+=" --without-libssh2"
if [ "${NACL_DEBUG}" = "1" ]; then
  NACLPORTS_CPPFLAGS+=" -DDEBUGBUILD"
  EXTRA_CONFIGURE_ARGS+=" --enable-debug --disable-curldebug"
fi

InstallStep() {
  DefaultInstallStep
  MakeDir ${DESTDIR}${PREFIX}/share/curl
  LogExecute ${SRC_DIR}/lib/mk-ca-bundle.pl \
      ${DESTDIR}${PREFIX}/share/curl/ca-bundle.crt
}

PublishStep() {
  if [ "${NACL_SHARED}" = "1" ]; then
    EXECUTABLE_DIR=.libs
  else
    EXECUTABLE_DIR=.
  fi

  MakeDir ${PUBLISH_DIR}

  LogExecute cp ${DESTDIR}${PREFIX}/share/curl/ca-bundle.crt ${PUBLISH_DIR}

  InstallNaClTerm ${PUBLISH_DIR}
  LogExecute cp ${START_DIR}/index.html ${PUBLISH_DIR}
  LogExecute cp ${START_DIR}/curl.js ${PUBLISH_DIR}
}
