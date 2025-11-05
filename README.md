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

### Artifact Behavior

| Event                   | Artifact Type | Retention | Deployment                        |   
|-------------------------|---------------|-----------|-----------------------------------|
| **push**                | Temporary     | 3 days    | _Not deployed_                    |
| **release (published)** | Persistent    | Permanent | HTML deployed to **GitHub Pages** |

In short:  
- Regular pushes are great for previewing or testing document builds.  
- Publishing a release will generate and upload permanent artifacts and automatically deploy your HTML output to GitHub Pages.


## Local Build

You can also build locally without GitHub Actions:

```bash
./docframe/scripts/build.sh path/to/markdown.md
```
Ensure Pandoc and XeLaTeX are installed on your system.
