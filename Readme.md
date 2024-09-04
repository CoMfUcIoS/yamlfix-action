# Yamlfix Action

A Github action to fix yaml files.

# Usage

Example workflow to run the action on push:

```yaml
name: Yamlfix

on:
  pull_request:
    branches: [main]
    paths:
      - "*.yml"
      - "*.yaml"

jobs:
  format-yaml-files:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Get file changes
        id: get_file_changes
        uses: trilom/file-changes-action@v1.2.3
        with:
          output: " "
      - name: Select only the yaml files
        id: changed_yaml_files
        run: |
          echo ${{ steps.get_file_changes.outputs.files }} | xargs -n 1 | grep -E "\.yml$|\.yaml$" > changed_files.txt
          cat changed_files.txt
          ::set-output name=files::$(cat changed_files.txt)
      - name: Yamlfix
        id: yamlfix
        uses: comfucios/yamlfix-action@v1.0.4
        with:
          files: ${{ steps.changed_yaml_files.outputs.files }}
      - name: commit-changes
        if: ${{ steps.yamlfix.outputs.changed_files == 'true' }}
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "Apply Yamlfix changes"
          file_pattern: "*.yml *.yaml"
```
