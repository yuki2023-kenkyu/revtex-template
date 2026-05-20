# Makefile for latexdiff on Windows + mingw32-make

OLD  ?= main.tex
NEW  ?= main_new.tex
DIFF ?= diff

OUTDIR ?= out

LATEXDIFF      ?= latexdiff
LATEXDIFF_OPTS ?= --flatten --type=UNDERLINE --subtype=SAFE

LATEXMK      ?= latexmk
LATEXMK_OPTS ?= -interaction=nonstopmode -halt-on-error -file-line-error

AUX_EXTS = aux bbl bcf blg fdb_latexmk fls log out run.xml toc lof lot synctex.gz xdv dvi ps

.PHONY: diff clean-diff-before clean-diff-aux clean distclean help

diff:
	$(MAKE) clean-diff-before
	$(LATEXDIFF) $(LATEXDIFF_OPTS) "$(OLD)" "$(NEW)" > "$(DIFF).tex"
	$(LATEXMK) $(LATEXMK_OPTS) "$(DIFF).tex"
	$(MAKE) clean-diff-aux

clean-diff-before:
	-$(LATEXMK) -C "$(DIFF).tex"
	-@for %%e in ($(AUX_EXTS)) do if exist "$(DIFF).%%e" del /Q "$(DIFF).%%e"
	-@for %%e in ($(AUX_EXTS)) do if exist "$(OUTDIR)\$(DIFF).%%e" del /Q "$(OUTDIR)\$(DIFF).%%e"
	-@if exist "$(DIFF).tex" del /Q "$(DIFF).tex"
	-@if exist "$(DIFF).pdf" del /Q "$(DIFF).pdf"
	-@if exist "$(OUTDIR)\$(DIFF).pdf" del /Q "$(OUTDIR)\$(DIFF).pdf"

clean-diff-aux:
	-@for %%e in ($(AUX_EXTS)) do if exist "$(DIFF).%%e" del /Q "$(DIFF).%%e"
	-@for %%e in ($(AUX_EXTS)) do if exist "$(OUTDIR)\$(DIFF).%%e" del /Q "$(OUTDIR)\$(DIFF).%%e"
	-@if exist "$(DIFF).tex" del /Q "$(DIFF).tex"

clean:
	-@for %%e in ($(AUX_EXTS)) do if exist "$(DIFF).%%e" del /Q "$(DIFF).%%e"
	-@for %%e in ($(AUX_EXTS)) do if exist "$(OUTDIR)\$(DIFF).%%e" del /Q "$(OUTDIR)\$(DIFF).%%e"
	-@if exist "$(DIFF).tex" del /Q "$(DIFF).tex"

distclean: clean
	-@if exist "$(DIFF).pdf" del /Q "$(DIFF).pdf"
	-@if exist "$(OUTDIR)\$(DIFF).pdf" del /Q "$(OUTDIR)\$(DIFF).pdf"

help:
	@echo Usage:
	@echo   mingw32-make diff OLD=main_revised_v2.tex NEW=main_revised_v3.tex
	@echo.
	@echo Variables:
	@echo   OLD    old LaTeX source
	@echo   NEW    new LaTeX source
	@echo   DIFF   diff output basename, default: diff
	@echo   OUTDIR output directory, default: out