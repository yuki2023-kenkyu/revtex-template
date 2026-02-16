# .latexmkrc  (REVTeX + BibTeX)  --- cleaned-up 강화版

$pdf_mode = 1;  # pdflatex

$out_dir = 'out';
$aux_dir = 'out';

$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex   = 'bibtex %O %B';

$max_repeat = 5;

# ----------------------------
# Cleanup 強化
# ----------------------------

# BibTeX運用で .bbl を「再生成可能」とみなして -c/-C の削除対象に含める
# （テンプレ repo で .bib を同梱する前提なら、この設定が実務的に便利）
$bibtex_use = 2;  # .bbl を clean で消す :contentReference[oaicite:2]{index=2}

# -c / -C 実行時に追加で消したい拡張子（スペース区切り）
# latexmk の既定でも多くは消えますが、環境/パッケージで残りがちなものを明示追加します。
$clean_ext .= ' '
  . 'bbl blg '              # 参考文献（上の $bibtex_use=2 とセットで効く）
  . 'run.xml bcf '          # biber/biblatex系（混入しても掃除できる）
  . 'fdb_latexmk fls '       # latexmk/recorder
  . 'synctex.gz '            # SyncTeX
  . 'toc lof lot '           # 目次・図目次・表目次
  . 'nav snm vrb '           # beamer系（混在時）
  . 'idx ilg ind ist xdy '   # makeindex/xindy
  . 'acn acr alg glg glo gls ' # glossaries/acronym
  . 'loa lol '               # algorithms/listings等で出ることがある
  . 'brf '                   # biblatex 等で出ることがある
;

# さらに「ファイル名パターン」で消すことも可能（%R=ルート名）。必要なら有効化。
# 例: $clean_ext .= ' %R-blx.bib %R-figures*.log';  :contentReference[oaicite:3]{index=3}

# （任意）カスタム依存（自作生成物）も clean で消したい場合にON
# ただし custom dependency の扱いは運用次第なので、必要になったら有効化推奨。
# $cleanup_includes_cusdep_generated = 1;  :contentReference[oaicite:4]{index=4}
