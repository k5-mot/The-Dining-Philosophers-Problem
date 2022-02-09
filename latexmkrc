#!/usr/bin/env perl

## LaTeX
$latex_args        = '-synctex=1 -halt-on-error -shell-escape -file-line-error %O %S ';
$latex_silent_args = $latex_args . '-interaction=batchmode ';
$pdflatex_args     = '-syntex=1 -halt-on-error %O %S ';
$pdflatex          = 'pdflatex ' . $pdflatex_args;
$latex             = 'platex ' . $latex_args;
$latex_silint      = 'platex ' . $latex_silent_args;
$max_repeat        = 5;

## BibTeX
$bibtex            = 'pbibtex %O %S';
$biber             = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';

## Index
$makeindex         = 'mendex %O -o %D %S';

## DVI, PDF
$dvipdf            = 'dvipdfmx %O -o %D %S';
#$pdf_mode         = 0;# PDFを生成しない
#$pdf_mode         = 1;# pdflatexを用いる
#$pdf_mode         = 2;# ps2pdfを用いる
$pdf_mode          = 3;# dvipdfmxを用いる

## Out directory
$out_dir           = 'build';
$aux_dir           = $out_dir;

## Preview
$pvc_view_file_via_temporary = 0;
if ($^O eq 'linux') {
    $dvi_previewer = "okular %S";
    $pdf_previewer = "okular %S";
} elsif ($^O eq 'darwin') {
    $dvi_previewer = "open %S";
    $pdf_previewer = "open %S";
} else {
    $dvi_previewer = "start %S";
    $pdf_previewer = "start %S";
}

## Clean up
$clean_full_ext = "%R.synctex.gz"
