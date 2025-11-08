# DocFrame

**DocFrame** is a lightweight framework for building styled HTML and PDF documents from Markdown 
using **Pandoc**.   It provides a consistent set of templates, styles, and a reusable GitHub
Actions workflow.

---

## Features

- Reusable Pandoc **HTML + LaTeX templates**
- Base **CSS styling** for web output
- Shell **build script** for local builds
- Reusable **GitHub Actions workflow** for automated builds

---

## Usage as a Submodule

To use **DocFrame** in another repository:

```bash
git submodule add https://github.com/tobiaslocker/docframe.git
git submodule update --init --recursive
```

## Using the Reusable Workflow

Create a workflow in your project (e.g. .github/workflows/build.yml):

```yaml
name: Build Document

on:
  push:
    branches: [ main ]

jobs:
  build:
    uses: tobiaslocker/docframe/.github/workflows/build-workflow.yml@main
    with:
      md_file: src/index.md
      metadata_file: src/metadata.yaml
```

## Local Build

You can also build locally without GitHub Actions:

```bash
./docframe/scripts/build.sh path/to/markdown.md
```
Ensure Pandoc and XeLaTeX are installed on your system.
