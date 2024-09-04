#!/bin/sh

_output() {
  local value=${1}
  echo "changed_files=$value" >>$GITHUB_OUTPUT
}

ls -lah

echo "$@"

which yamlfix

yamlfix "$@" >/tmp/yamlfix_output 2>&1

cat test.yaml

if grep -q "0 fixed" /tmp/yamlfix_output; then
  _output "false"
else
  _output "true"
fi
