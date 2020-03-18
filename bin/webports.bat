:: Copyright 2020 Samsung Electronics. All rights reserved.
:: Use of this source code is governed by a BSD-style license that can be
:: found in the LICENSE file.
@echo off

set "SCRIPT_DIR=%~dp0"

cmd /c "%SCRIPT_DIR%\..\build_tools\python_wrapper.bat" -m webports %*