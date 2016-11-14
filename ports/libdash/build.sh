#!/bin/bash

EnableGlibcCompat

ConfigureStep() {
  SetupCrossEnvironment
  DefaultConfigureStep
}
