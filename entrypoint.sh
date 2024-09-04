#!/bin/sh

_output() {
  local value=${1}
  echo "changed_files=$value" >>$GITHUB_OUTPUT
}

ls -lah

cat test.yaml

echo "$@"

which yamlfix

yamlfix "$@" >/tmp/yamlfix_output 2>&1

if grep -q "0 fixed" /tmp/yamlfix_output; then
  _output "false"
else
  _output "true"
fi
