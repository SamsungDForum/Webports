# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# needed for RLIMIT_CPU
EnableGlibcCompat

ConfigureStep() {

  SetupCrossEnvironment

  local extra_args=""
  if [ "${TOOLCHAIN}" = "pnacl" ]; then
    extra_args="--cc=pnacl-clang"
  elif [ "${TOOLCHAIN}" = "clang-newlib" ]; then
    extra_args="--cc=${CC}"
  fi

  if [ "${NACL_ARCH}" = "pnacl" ]; then
    extra_args+=" --arch=pnacl"
  elif [ "${NACL_ARCH}" = "arm" ]; then
    extra_args+=" --arch=arm"
  else
    extra_args+=" --arch=x86"
  fi

  LogExecute ${SRC_DIR}/configure \
    --cross-prefix=${NACL_CROSS_PREFIX}- \
    --target-os=linux \
    --disable-everything \
    --disable-programs \
    --enable-gpl \
    --enable-static \
    --enable-cross-compile \
    --enable-decoder=aac,h264,mjpeg,mpeg2video,mpeg4 \
    --enable-encoder=aac,mpeg4,libx264 \
    --enable-protocol=concat,file \
    --enable-demuxer=aac,avi,h264,hevc,image2,matroska,pcm_s16le,mov,m4v,rawvideo,wav \
    --enable-muxer=h264,ipod,mov,mp4 \
    --enable-parser=aac,h264,hevc,mjpeg,mpeg4video,mpegaudio,mpegvideo,png \
    --enable-bsf=aac_adtstoasc \
    --enable-filter=transpose \
    --disable-decoder=dpx \
    --prefix=${PREFIX} \
    ${extra_args}
}
