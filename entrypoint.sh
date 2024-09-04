#!/bin/sh

_output() {
  local value=${1}

  if [ -z ${GITHUB_OUTPUT+x} ]; then
    echo "::set-output name=changed_files::$value"
  else
    echo "changed_files=$value" >>$GITHUB_OUTPUT
  fi
}

ls -lah

git status

yamlfix "$@" >/tmp/yamlfix_output 2>&1

if grep -q "0 fixed" /tmp/yamlfix_output; then
  _output "false"
else
  _output "true"
fi
