# Yamlfix Action

A Github action to fix yaml files.

# Usage

```yaml
name: Yamlfix

on: [push]

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
      - name: Echo file changes
        run: |
          echo Changed files: ${{ steps.get_file_changes.outputs.files }}
      - name: Yamlfix
        id: yamlfix
        uses: comfucios/yamlfix-action@v1
        with:
          files: ${{ steps.get_file_changes.outputs.files }}
      - name: commit-changes
        if: ${{ steps.yamlfix.outputs.changed_files == 'true' }}
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "Apply Yamlfix changes"
          file_pattern: "*.yml *.yaml"
```
