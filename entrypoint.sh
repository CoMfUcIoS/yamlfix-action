#!/bin/sh

_output() {
  value=${1}
  echo "changed_files=$value" >>$GITHUB_OUTPUT
}

files="$@"

echo "Fixing file $files"
yamlfix $files >/tmp/yamlfix_output

cat test.yaml

if [ -s /tmp/yamlfix_output ]; then
  _output "true"
else
  _output "false"
fi
