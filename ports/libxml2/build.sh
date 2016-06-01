# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

MAKE_TARGETS="libxml2.la"
INSTALL_TARGETS="install-libLTLIBRARIES install-data"
EXTRA_CONFIGURE_ARGS="--with-python=no"
EXTRA_CONFIGURE_ARGS+=" --with-iconv=no"

EXTRA_CONFIGURE_ARGS+=" --with-http"

if [ "${NACL_LIBC}" = "newlib" ]; then
  NACLPORTS_CFLAGS+=" -I${NACLPORTS_INCLUDE}/glibc-compat"
  NACLPORTS_LDFLAGS+=" -lnacl_io"
fi
