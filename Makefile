default: slides

all: slides handout

BIBLIOGRAPHIES= data-science-bib/data_science.bib \
				talk.bib

bibliography: $(BIBLIOGRAPHIES)
	cat $(BIBLIOGRAPHIES) > data.bib

SOURCE=open_science_seminar

# Need gpp for conditional stuff
# `brew install gpp` on macOS

slides: bibliography $(SOURCE).md
	gpp -H $(SOURCE).md | pandoc \
	    --filter pandoc-citeproc \
	    -t beamer \
	    -o $(SOURCE)_slides.pdf

handout: bibliography $(SOURCE).md
	gpp -H -DHANDOUT=1 $(SOURCE).md | pandoc \
	    --filter pandoc-citeproc \
	    -o $(SOURCE)_handout.pdf

clean:
	rm -f *.pdf *.html
