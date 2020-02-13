Samsung webports fork
=====================

This is a fork of webports repository adapted to facilitate Samsung TV
specific features.

Our fork doesn't use gclient, so before building weports as described in
[README.md](./README.md) please use following steps:

1. Install pip:

$ ./build_tools/pip_install.sh

2. Sync dependencies:

$ python samsung_webports_deps.py

3. If you are using pepper_63 toolchain you need to build gtest, because it
is required by some webports and it is not bundled with this toolchain

$ make gtest

After performing these steps you can start building weports as described
in [README.md](./README.md)

*Note*:

1. After performing these steps please don't run gclient sync as described
in [How to Checkout chapter of README.md]

2. Currently webports require python2. Migration to python3 is in
progress :(
