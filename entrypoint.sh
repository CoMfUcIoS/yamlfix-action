#!/bin/sh

_output() {
  value=${1}
  echo "changed_files=$value" >>$GITHUB_OUTPUT
}

_file_changed=false

for file in "$@"; do
  echo "Fixing file $file"
  yamlfix $file >/tmp/yamlfix_output
  if grep -q "0 fixed" /tmp/yamlfix_output; then
    continue
  else
    _file_changed=true
  fi
done

ls -lah

cat test.yaml

_output $_file_changed
