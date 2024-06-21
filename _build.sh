#!/bin/sh

set -ev

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', encoding='UTF-8')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book', encoding='UTF-8')"
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book', encoding='UTF-8')"

