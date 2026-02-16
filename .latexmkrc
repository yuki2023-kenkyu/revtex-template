# .latexmkrc  (REVTeX + BibTeX)
$pdf_mode = 1;  # pdflatex

$out_dir = 'out';
$aux_dir = 'out';

$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex   = 'bibtex %O %B';

$max_repeat = 5;

$clean_ext .= ' run.xml bcf';
