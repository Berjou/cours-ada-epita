PDF_VIEWER ?= zathura
PDF_VIEWERARGS ?= --fork

COURSE_MD = course.md
COURSE_PDF = course.pdf

TP_MD = tp_exercises.md
TP_PDF = tp_exercises.pdf

all: build

build: $(COURSE_PDF) $(TP_PDF)

$(COURSE_PDF):
	pandoc \
		-t beamer \
		--pdf-engine=xelatex \
		--template=./default.beamer \
		--highlight-style=zenburn \
		-s \
		-V theme=metropolis \
		-V fontsize=9pt \
		-V monofont="DejaVu Sans Mono" \
		-V monofontoptions=Scale=0.9 \
		$(COURSE_MD) -o $(COURSE_PDF)

$(TP_PDF):
	pandoc $(TP_MD) -o $(TP_PDF)

view: view_course view_tp

view_course: $(COURSE_PDF)
	$(PDF_VIEWER) $(PDF_VIEWERARGS) $(COURSE_PDF)

view_tp: $(TP_PDF)
	$(PDF_VIEWER) $(PDF_VIEWERARGS) $(TP_PDF)

clean:
	$(RM) $(COURSE_PDF) $(TP_PDF)

.PHONY: all build clean view view_course view_tp
