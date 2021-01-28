:: Copyright 2020 Samsung Electronics. All rights reserved.
:: Use of this source code is governed by a BSD-style license that can be
:: found in the LICENSE file.

:: Wrapper for system python that first set PYTHONUSERBASE so that
:: the python modules installed via pip (during glclient runhooks)
:: are accessible.
@echo off

set "SCRIPT_DIR=%~dp0\.."
set "PYTHONPATH=%PYTHONPATH%;%SCRIPT_DIR%;%SCRIPT_DIR%\lib"
set "PYTHONUSERBASE=%SCRIPT_DIR%\out\pip"

if not exist "%PYTHONUSERBASE%" (
  echo "error: pip installation not found (%PYTHONUSERBASE%)"
  echo "Did you use gclient to fetch the webports repo?"
  echo "(See top level README to details)"
) else (
  python %*
)