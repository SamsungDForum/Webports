# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# needed for RLIMIT_CPU
EnableGlibcCompat

ConfigureStep() {
  SetupCrossEnvironment

  local lib_type="--enable-static"

  local extra_args=""
  if [ "${TOOLCHAIN}" = "pnacl" ]; then
    extra_args="--cc=pnacl-clang"
  elif [ "${TOOLCHAIN}" = "clang-newlib" ]; then
    extra_args="--cc=${CC}"
  fi

  if [ "${NACL_ARCH}" = "pnacl" ]; then
    extra_args+=" --arch=pnacl"
  elif [ "${NACL_ARCH}" = "arm" ]; then
    # inline-asm causes compilation problems under glibc-arm
    # asm causes ncval validation errors for shared libs produced by glibc-arm
    extra_args+=" --arch=arm --disable-asm"
    lib_type="--enable-shared"
  else
    extra_args+=" --arch=x86"
  fi

  LogExecute ${SRC_DIR}/configure \
    --cross-prefix=${NACL_CROSS_PREFIX}- \
    --target-os=linux \
    --disable-everything \
    --disable-programs \
    --enable-cross-compile \
    --enable-decoder=aac,h264,mjpeg,mpeg2video,mpeg4 \
    --enable-encoder=aac,mpeg4,libx264 \
    --enable-protocol=concat,file \
    --enable-demuxer=aac,ac3,avi,dts,dtshd,eac3,h264,hevc,image2,matroska,pcm_s16le,mov,mpegts,mpegtsraw,m4v,rawvideo,wav \
    --enable-muxer=h264,ipod,mov,mp4 \
    --enable-parser=aac,ac3,h264,hevc,mpegts,mpegtsraw,mjpeg,mpeg4video,mpegaudio,mpegvideo,png \
    --enable-bsf=aac_adtstoasc \
    --enable-filter=transpose \
    --disable-decoder=dpx \
    --prefix=${PREFIX} \
    ${lib_type} \
    ${extra_args}
}
