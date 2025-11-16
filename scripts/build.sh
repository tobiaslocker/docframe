#!/usr/bin/env bash

set -euo pipefail

# ------------------------------------------------------------
# Default values (same as GitHub reusable workflow)
# ------------------------------------------------------------
MD_FILE=""
METADATA_FILE=""
HTML_TEMPLATE="docframe/templates/default.html"
TEX_TEMPLATE="docframe/templates/default.tex"
OUTPUT_NAME="output"

BUILD_HTML=false
BUILD_PDF=false

# ------------------------------------------------------------
# Help
# ------------------------------------------------------------
usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --md <file>             Markdown source file (required)"
    echo "  --metadata <file>       Metadata YAML file (required)"
    echo "  --html-template <file>  HTML template (default: $HTML_TEMPLATE)"
    echo "  --tex-template <file>   LaTeX template (default: $TEX_TEMPLATE)"
    echo "  --output-name <name>    Output file base name (default: $OUTPUT_NAME)"
    echo "  --html                  Build HTML"
    echo "  --pdf                   Build PDF"
    echo "  --all                   Build both HTML and PDF"
    echo "  -h, --help              Show this help"
}

# ------------------------------------------------------------
# Argument parsing
# ------------------------------------------------------------
while [[ $# -gt 0 ]]; do
    case "$1" in
        --md)
            MD_FILE="$2"; shift 2 ;;
        --metadata)
            METADATA_FILE="$2"; shift 2 ;;
        --html-template)
            HTML_TEMPLATE="$2"; shift 2 ;;
        --tex-template)
            TEX_TEMPLATE="$2"; shift 2 ;;
        --output-name)
            OUTPUT_NAME="$2"; shift 2 ;;
        --html)
            BUILD_HTML=true; shift ;;
        --pdf)
            BUILD_PDF=true; shift ;;
        --all)
            BUILD_HTML=true; BUILD_PDF=true; shift ;;
        -h|--help)
            usage; exit 0 ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# ------------------------------------------------------------
# Validate required inputs
# ------------------------------------------------------------
if [[ -z "$MD_FILE" ]]; then
    echo "Error: --md is required"; exit 1
fi

if [[ -z "$METADATA_FILE" ]]; then
    echo "Error: --metadata is required"; exit 1
fi

if ! $BUILD_HTML && ! $BUILD_PDF; then
    echo "No build target selected. Use --html, --pdf or --all."
    exit 1
fi

# ------------------------------------------------------------
# Create output directories
# ------------------------------------------------------------
mkdir -p build/html
mkdir -p build/pdf

# ------------------------------------------------------------
# Build HTML
# ------------------------------------------------------------
if $BUILD_HTML; then
    echo "Building HTML..."
    pandoc "$MD_FILE" \
        --template="$HTML_TEMPLATE" \
        --metadata-file="$METADATA_FILE" \
        -o "build/html/index.html"

    # Optional: copy styles (mirroring GitHub workflow)
    if [[ -d docframe/styles ]]; then
        cp -r docframe/styles build/html/
    fi

    echo "HTML written to build/html/index.html"
fi

# ------------------------------------------------------------
# Build PDF
# ------------------------------------------------------------
if $BUILD_PDF; then
    echo "Building PDF..."
    pandoc "$MD_FILE" \
        --template="$TEX_TEMPLATE" \
        --metadata-file="$METADATA_FILE" \
        --pdf-engine=xelatex \
        -o "build/pdf/${OUTPUT_NAME}.pdf"

    echo "PDF written to build/pdf/${OUTPUT_NAME}.pdf"
fi

echo "Done."
