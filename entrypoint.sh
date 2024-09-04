#!/bin/sh

_output() {
  value=${1}
  echo "changed_files=$value" >>$GITHUB_OUTPUT
}

files="$@"

yamlfix $files >/tmp/yamlfix_output

if grep -q "0 fixed" /tmp/yamlfix_output; then
  _output "false"
else
  _output "true"
fi
