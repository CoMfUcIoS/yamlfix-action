#!/bin/sh

_output() {
  local value=${1}

  if [ -z ${GITHUB_OUTPUT+x} ]; then
    echo "::set-output name=changes_files::$value"
  else
    echo "changes_files=$value" >>$GITHUB_OUTPUT
  fi
}

yamlfix "$@" >/tmp/yamlfix_output 2>&1

if grep -q "0 fixed" /tmp/yamlfix_output; then
  _output "false"
else
  _output "true"
fi
