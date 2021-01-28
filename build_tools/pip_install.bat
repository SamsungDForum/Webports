:: Copyright 2020 Samsung Electronics. All rights reserved.
:: Use of this source code is governed by a BSD-style license that can be
:: found in the LICENSE file.

:: Installs required python modules using 'pip'.
:: Always use a locally installed version of pip rather than relying
:: on the system version since the behaviour and command line flags
:: for pip inself vary between versions.
@echo off

set "SCRIPT_DIR=%~dp0"
set "ARGS=--user --no-compile"

cd "%SCRIPT_DIR%\.."

set "PYTHONUSERBASE=%CD%\out\pip"

set "pip_bin_dir=%PYTHONUSERBASE%\bin"
set "pip_bin=%pip_bin_dir%\pip"
set "PATH=%pip_bin_dir%;%PATH%"

if not exist "%pip_bin%" (
  rem On first run install pip directly from the network
  echo "Installing pip.."
  rem Use local file rather than pipeline so we can detect failure of the curl
  rem command.
  curl -O --silent --show-error https://bootstrap.pypa.io/get-pip.py
  python get-pip.py --force-reinstall --user
  del /f get-pip.py
)

:: At this point we know we have good pip install in $PATH and we can use
:: it to install the requirements.
pip install %ARGS% -r requirements.txt
