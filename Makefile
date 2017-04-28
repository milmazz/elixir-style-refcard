DOC = elixir-style-refcard
CONVERT = convert
LATEX = lualatex

all: $(DOC).pdf $(DOC)-a4.pdf $(DOC)-0.png $(DOC)-thumb-0.png

clean:
	rm -f $(DOC).pdf $(DOC)-a4.tex $(DOC)-a4.pdf \
		$(DOC)-0.png $(DOC)-1.png \
		$(DOC)-thumb-0.png $(DOC)-thumb-1.png \
		$(DOC).out $(DOC)-a4.out $(DOC).log $(DOC).aux

$(DOC).pdf: $(DOC).tex
	$(LATEX) $(DOC).tex
	rm -f $(DOC).aux $(DOC).log $(DOC).out

$(DOC)-a4.tex: $(DOC).tex
	cat $(DOC).tex | sed -e 's/\\usepackage\[landscape\]/\\usepackage\[a4paper,landscape\]/' > $(DOC)-a4.tex

$(DOC)-a4.pdf: $(DOC)-a4.tex
	$(LATEX) $(DOC)-a4.tex
	rm -f $(DOC)-a4.tex $(DOC)-a4.aux $(DOC)-a4.log $(DOC)-a4.out

$(DOC)-0.png: $(DOC).pdf
	$(CONVERT) -density 100x100 -background white +adjoin $(DOC).pdf $(DOC)-%d.png

$(DOC)-thumb-0.png: $(DOC).pdf
	$(CONVERT) -density 32x32 -background white +adjoin $(DOC).pdf $(DOC)-thumb-%d.png
