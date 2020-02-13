#!/usr/bin/env python
# ##
# Copyright (c) 2016 Samsung Electronics. All rights reserved.

# Manage Webports dependencies stored in WEBPORTS_DIR/DEPS file.

import os
import subprocess
import sys

DEPS_FILE_NAME = 'DEPS'

def ReadWebportDeps():
  deps_path = DEPS_FILE_NAME
  local_scope = {}
  try:
    with open(deps_path) as deps_file:
      deps_content = deps_file.read()
    exec(deps_content, globals(), local_scope)
  except Exception as exception:
    print(('ERROR: Cannot read ' + deps_path + '! Reason:\n' + str(exception)));
    return {}
  return local_scope.get('deps', {})

def SyncWebportDep(path, git_url, git_commit):
  # FIXME: this check should be more precise...
  if os.path.isdir(path):
    return True

  print(('* Syncing Webport dependency ' + path + '...'))

  git_args = [
      'git', 'clone', git_url,
      '--recurse-submodules',
      path]
  git_rc = subprocess.call(git_args)

  if git_rc != 0:
    return False

  git_args = [
      'git', 'checkout', git_commit]
  git_rc = subprocess.call(git_args, cwd = path)

  return (git_rc == 0);

def SyncWebportDeps():
  deps = ReadWebportDeps();
  for key in deps:
    dep_repo_info = deps[key].split('@')
    git_url = dep_repo_info[0]
    # 'git://' seems to be blocked on the firewall
    if 'git://' in git_url:
      git_url = git_url.replace('git://', 'https://') + '.git'
    git_commit = dep_repo_info[1]
    repo_path = key
    # Google assumes repo root is src, but it's not our case. Fix path:
    third_party_index = repo_path.find("third_party/")
    if (third_party_index == -1):
      print(('ERROR: ' + repo_path + ' is invalid path!'))
      continue
    repo_path = repo_path[third_party_index:len(repo_path)]
    if not SyncWebportDep(repo_path, git_url, git_commit):
      return False
  return True

def main():
  return SyncWebportDeps()

if __name__ == '__main__':
  if not main():
    sys.exit(1)
