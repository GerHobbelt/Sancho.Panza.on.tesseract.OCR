.PHONY: html pdf epub

html:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

epub:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

