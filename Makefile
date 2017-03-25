MKDIR_P = mkdir -p

sources := doc/01_intro.md doc/02_host.md  doc/03_cuckoo.md doc/04_cuckoo_api.md doc/05_cuckoo_web.md doc/06_virtualbox.md doc/07_guest.md
output := dist

all: directories pdf html

pdf: directories pdf_doc

html: directories html_doc

directories: $(output)

pdf_doc: $(output)/stack.pdf

html_doc: $(output)/index.html

$(output):
	$(MKDIR_P) $(output)

$(output)/stack.pdf: $(sources)
	cat $(sources) | pandoc \
	--variable geometry:a4paper \
	--number-sections \
	--toc \
	-f markdown \
	-s \
	-o $@

$(output)/index.html: $(sources)
	cat styles/splendor.md $(sources) | markdown - > $@

.PHONY : clean

clean:
	rm -f $(output)/*.pdf
	rm -f $(output)/*.html



