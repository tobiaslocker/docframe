#!/bin/bash

pandoc cv.md \
            --template=template.tex \
            --metadata-file=metadata.yaml \
            --pdf-engine=xelatex \
            -o build/pdf/cv.pdf
