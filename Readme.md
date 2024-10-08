# Yamlfix Action

A Github action to fix yaml files.

## Inputs

## `files`

**Required** The files to fix (space separated relative paths)

## Outputs

## `changed_files`

`true` if any files were changed, `false` otherwise

## Example Usage

Example workflow to run the action on push:

```yaml
---
name: Format yaml files
on:
  pull_request:
    branches: [main]
    paths: ["**/*.yml", "**/*.yaml"]
permissions:
  contents: write
  pull-requests: write
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
          # Remove dependabot.yml if exists in the list
          sed -i '/.github\/dependabot.yml/d' changed_files.txt || true
          yaml_files=$(cat changed_files.txt | tr '\n' ' ')
          rm changed_files.txt
          echo "files=${yaml_files}" >> $GITHUB_OUTPUT
      - name: Yamlfix
        id: yamlfix
        uses: comfucios/yamlfix-action@v1.0.8
        with:
          files: ${{ steps.changed_yaml_files.outputs.files }}
      - name: commit-changes
        if: ${{ steps.yamlfix.outputs.changed_files == 'true' }}
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: Apply Yamlfix format changes.
          status_options: --untracked-files=no
```
