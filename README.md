# revtex-template

REVTeX 4.2 を用いて英語の学術論文原稿を作成し、arXiv 投稿、ジャーナル投稿、改訂原稿提出、査読者レポートへの回答作成までを一貫して行うための最小テンプレートです。

このテンプレートは、本文原稿を `main.tex`、参考文献を `refs.bib`、査読回答書を `report.tex` として管理することを想定しています。ビルドは `latexmk` と `.latexmkrc` に集約し、VS Code + LaTeX Workshop でも同じ設定を使えるようにしています。差分原稿の作成には `makefile` の `diff` ターゲットを使います。

## 1. REVTeXのインストール

このテンプレートは `revtex4-2` クラスを使うため、REVTeX 4.2 を含むLaTeX環境が必要です。通常はREVTeX単体を手作業で配置するのではなく、TeX Live、MacTeX、またはMiKTeXのパッケージ管理機能で導入します。

インストール後にREVTeXが使えるかどうかは、次のコマンドで確認できます。

```bash
kpsewhich revtex4-2.cls
```

`revtex4-2.cls` のパスが表示されれば、REVTeX 4.2 は利用可能です。何も表示されない場合は、REVTeXパッケージが未導入、またはTeX環境のPATH設定に問題があります。

### 1.1 macOSの場合

macOSでは、MacTeXを使う方法を推奨します。MacTeXはTeX LiveをmacOS向けにまとめた配布版で、標準的なLaTeXパッケージ、BibTeX、`latexmk` などを一括して導入できます。

基本手順は以下です。

1. MacTeXをインストールする。
   - 公式サイト: https://tug.org/mactex/
   - 容量を抑えたい場合はBasicTeXも選択できますが、その場合は不足パッケージを追加で入れる必要があります。
2. ターミナルを開き、TeX環境が認識されているか確認する。

```bash
pdflatex --version
bibtex --version
latexmk --version
```

3. TeX Live Managerを更新する。

```bash
sudo tlmgr update --self --all
```

4. REVTeXや差分作成用ツールが不足している場合は、次を実行する。

```bash
sudo tlmgr install revtex latexmk latexdiff
```

5. REVTeXが見つかるか確認する。

```bash
kpsewhich revtex4-2.cls
```

このテンプレートでは `pdflatex` を標準にしているため、`latexmk main.tex` が通れば基本的な執筆環境は整っています。VS Codeを使う場合は、追加で LaTeX Workshop 拡張機能を導入してください。

### 1.2 Windowsの場合

Windowsでは、TeX Liveを使う方法とMiKTeXを使う方法があります。arXivやLinux環境での再現性を重視する場合はTeX Live、最小構成から始めたい場合はMiKTeXが扱いやすいです。

#### TeX Liveを使う場合

1. TeX Liveをインストールする。
   - 公式サイト: https://tug.org/texlive/
   - インストール時にPATHへ追加する設定を有効にします。
2. PowerShellまたはコマンドプロンプトで、TeX環境が認識されているか確認する。

```powershell
pdflatex --version
bibtex --version
latexmk --version
```

3. 必要に応じてTeX Live Managerを更新し、REVTeXと差分作成用ツールを導入する。

```powershell
tlmgr update --self --all
tlmgr install revtex latexmk latexdiff
```

管理者権限でインストールしたTeX Liveでは、PowerShellを管理者として開く必要がある場合があります。

4. REVTeXが見つかるか確認する。

```powershell
kpsewhich revtex4-2.cls
```

#### MiKTeXを使う場合

1. MiKTeXをインストールする。
   - 公式サイト: https://miktex.org/
2. MiKTeX Consoleを開き、`Updates` からパッケージを更新する。
3. `Settings` で不足パッケージの自動インストールを有効にする。
4. PowerShellまたはコマンドプロンプトで確認する。

```powershell
pdflatex --version
bibtex --version
latexmk --version
kpsewhich revtex4-2.cls
```

MiKTeXでは、初回コンパイル時に `revtex`、`latexmk`、`latexdiff` などの不足パッケージのインストールを求められることがあります。その場合は許可してください。自動インストールがうまくいかない場合は、MiKTeX Console の `Packages` から `revtex`、`latexmk`、`latexdiff` を検索して手動で導入します。

### 1.3 WindowsでMakefile差分作成を使う場合

このテンプレートの `makefile` は、Windowsでは `mingw32-make` から使うことを想定しています。本文PDFの作成だけなら `mingw32-make` は不要ですが、次のような差分PDF作成コマンドを使う場合には必要です。

```powershell
mingw32-make diff OLD=old_ver_filename.tex NEW=new_ver_filename.tex
```

`mingw32-make` がない場合は、TDM-GCC、MinGW、MSYS2などを導入し、`mingw32-make --version` がPowerShellまたはコマンドプロンプトで通るようにPATHを設定してください。

確認用コマンドは次です。

```powershell
latexdiff --version
mingw32-make --version
```

`mingw32-make` を使わない場合でも、次のように `latexdiff` を直接実行することで差分texを作成できます。

```powershell
latexdiff old_ver_filename.tex new_ver_filename.tex > diff.tex
latexmk diff.tex
```

## 2. ファイル構成

```text
revtex-template-main/
├─ main.tex                  # 論文本体のREVTeX原稿
├─ refs.bib                  # 論文本体用のBibTeXデータベース
├─ report.tex                # 査読者コメントへの回答書テンプレート
├─ report-for-1st-ref.bib    # 回答書用のBibTeXデータベース
├─ .latexmkrc                # latexmk設定。pdflatex + BibTeX + out/出力
├─ makefile                  # latexdiffによる差分PDF生成用
├─ .vscode/settings.json     # VS Code / LaTeX Workshop設定
├─ LICENSE
└─ out/                      # PDF・補助ファイルの出力先
```

通常の執筆では、主に `main.tex` と `refs.bib` を編集します。査読対応時には `report.tex` を編集し、必要に応じて `latexdiff` で旧版と新版の差分PDFを作成します。

## 3. 事前に必要な環境

以下が導入されていることを想定しています。

- TeX Live または MiKTeX
- `latexmk`
- `bibtex`
- `latexdiff`
- Windowsで `makefile` を使う場合は MinGW / TDM-GCC 等に含まれる `mingw32-make`
- VS Code を使う場合は LaTeX Workshop 拡張機能

Windows では、PowerShell またはコマンドプロンプトから次のコマンドで確認できます。

```powershell
pdflatex --version
bibtex --version
latexmk --version
latexdiff --version
mingw32-make --version
```

`command not found` や「認識されません」と表示される場合は、インストール不足またはPATH設定の問題です。

## 4. 論文本文の執筆方法

### 3.1 基本方針

論文本文は `main.tex` を編集します。テンプレート冒頭は次のREVTeX 4.2設定になっています。

```tex
\documentclass[preprint,aps,prd,nofootinbib,superscriptaddress,eqsecnum,tightenlines,floatfix]{revtex4-2}
```

主なオプションの意味は以下です。

| オプション | 意味 |
|---|---|
| `preprint` | 投稿前確認に適した1段組・読みやすい形式 |
| `aps` | APS系REVTeX形式 |
| `prd` | Physical Review D に近い体裁 |
| `nofootinbib` | 著者脚注等を参考文献に混ぜない |
| `superscriptaddress` | 著者所属を上付き番号で表示 |
| `eqsecnum` | 数式番号をセクション番号付きにする |
| `tightenlines` | 行間をやや詰める |
| `floatfix` | 図表配置の問題を緩和する |

投稿先ジャーナルの指定がある場合は、そのジャーナルの author guidelines を必ず確認し、必要ならクラスオプションを変更してください。例えば二段組の最終見た目を確認したい場合は `preprint` ではなく `reprint` を使います。ただし、初回投稿時は読みやすさを優先して `preprint` 形式を求められる場合もあります。

### 3.2 著者・所属・ORCID

`main.tex` の以下を実際の情報に置き換えます。

```tex
\title{Title of the Manuscript}

\author{Your Name\ORCID{0000-0000-0000-0000}}
\email{email-address}
\affiliation{Affiliation}
```

複数著者の場合は、`\author{...}`、`\email{...}`、`\affiliation{...}` を著者ごとに追加します。対応著者のメールは `\email{...}` で明示します。

### 3.3 Abstract と本文構成

典型的には、次の順序で本文を構成します。

```tex
\begin{abstract}
Abstract text.
\end{abstract}
\maketitle

\section{Introduction}
\section{Method}
\section{Results}
\section{Discussion}
\section{Conclusion}

\begin{acknowledgments}
Acknowledgments.
\end{acknowledgments}

\bibliographystyle{apsrev4-2}
\bibliography{refs}
```

分野や投稿先によって節名は変えて構いません。宇宙論・高エネルギー物理系の論文では、Introduction で背景、先行研究、未解決点、本研究の目的と新規性を明確に述べ、Method / Model / Analysis で理論または解析手法を定式化し、Results で主要な結果、Conclusion で意義と限界を簡潔にまとめる構成が扱いやすいです。

### 3.4 数式・図表・相互参照

数式は `equation`、`align`、`gather` などを使います。

```tex
\begin{equation}
  H^2 = \frac{8\pi G}{3}\rho .
  \label{eq:friedmann}
\end{equation}
```

このテンプレートでは `zref-clever` を読み込んでいるため、相互参照には原則として `\zcref{...}` を使います。

```tex
As shown in \zcref{eq:friedmann}, ...
```

図は `graphicx` により読み込みます。

```tex
\begin{figure}[tbp]
  \centering
  \includegraphics[width=0.8\linewidth]{figures/example.pdf}
  \caption{Caption text.}
  \label{fig:example}
\end{figure}
```

表はREVTeXの `ruledtabular` を使うとAPS系に近い体裁になります。

```tex
\begin{table}[tbp]
\caption{Caption text.\label{tab:example}}
\begin{ruledtabular}
\begin{tabular}{lcc}
Quantity & Case A & Case B \\
\hline
Value & 1 & 2 \\
\end{tabular}
\end{ruledtabular}
\end{table}
```

図表のファイル名は、英数字・ハイフン・アンダースコア程度に留めることを推奨します。大文字小文字も投稿システム上は区別されることがあるため、`figure1.pdf` と `Figure1.pdf` の混在を避けてください。

### 3.5 参考文献

参考文献は `refs.bib` にBibTeX形式で記述し、本文中では `\cite{...}` で引用します。

```tex
This method is based on previous work~\cite{einstein1905}.
```

`main.tex` 末尾では、次を維持します。

```tex
\bibliographystyle{apsrev4-2}
\bibliography{refs}
```

投稿前には、本文中で引用した文献がすべて `refs.bib` に含まれていること、未引用の不要な文献が混ざっていないこと、DOI・arXiv番号・著者名・出版年が正しいことを確認してください。

## 5. ビルド方法

### 4.1 VS Codeでのビルド

VS Codeでこのフォルダを開き、`main.tex` を開いた状態で LaTeX Workshop の `Build LaTeX project` を実行します。`.vscode/settings.json` により、`latexmk (latexmkrc)` レシピが使われます。

生成物は `out/` に出力されます。

```text
out/main.pdf
```

### 4.2 コマンドラインでのビルド

PowerShell、コマンドプロンプト、またはターミナルでテンプレートのルートディレクトリに移動し、次を実行します。

```powershell
latexmk main.tex
```

`.latexmkrc` により、`pdflatex` と `bibtex` が必要回数実行され、PDFは `out/main.pdf` に生成されます。

明示的にPDFビルドしたい場合は次でも構いません。

```powershell
latexmk -pdf main.tex
```

補助ファイルを削除する場合は次を実行します。

```powershell
latexmk -c main.tex
```

PDFも含めて完全に削除する場合は次を実行します。

```powershell
latexmk -C main.tex
```

## 6. 図ファイル形式の注意

このテンプレートの `.latexmkrc` は `pdflatex` を使います。そのため、図は原則として `pdf`、`png`、`jpg` を推奨します。

EPS図を使う場合は、以下のどちらかに統一してください。

1. EPSをPDFに変換して `pdflatex` で処理する。
2. ビルド方式を `latex -> dvips -> ps2pdf` に変更し、arXiv投稿時にもLaTeX処理を選ぶ。

`pdflatex` 用の原稿にEPS、LaTeX処理用の原稿にPNG/PDFを混在させると、ローカル環境では通っても投稿システムで失敗する場合があります。投稿前に、投稿先のシステムで選ぶTeX engineと図形式を必ず整合させてください。

## 7. arXiv投稿用の準備

### 6.1 投稿前チェック

arXivへ投稿する前に、以下を確認します。

- ローカルで `out/main.pdf` がエラーなしで生成される。
- タイトル、著者、所属、Abstract、本文、Acknowledgments が最終版になっている。
- `refs.bib` と引用キーが整合している。
- 図表ファイルがすべて含まれている。
- 図表のファイル名に空白、日本語、括弧、特殊記号を使っていない。
- 本文中の `\includegraphics{...}` のパスとファイル名の大文字小文字が一致している。
- 投稿しない補助ファイル、古いPDF、差分PDF、メモファイルが混ざっていない。
- 生成AI等を使って文章を作成した場合でも、著者自身が本文・数式・参考文献・主張の正確性を確認している。

### 6.2 arXivに含める典型的なファイル

最小構成は次のようになります。

```text
main.tex
refs.bib
figures/figure1.pdf
figures/figure2.pdf
...
```

現在のarXivでは、必要な `.bib` ファイルが含まれていれば、投稿システム側でBibTeX処理が行われる場合があります。ただし、再現性を重視する場合や特殊な文献処理を使う場合は、ローカルで生成した `main.bbl` も同梱する運用が安全です。`.bbl` を入れる場合は、メインファイル名と対応する名前、すなわち `main.tex` に対して `main.bbl` とし、本文と同じツールチェーンで生成したものを使います。

このテンプレートでは `biblatex` ではなく通常のBibTeX運用を想定しています。`biblatex` + `biber` に変更する場合は、投稿先システムのTeX Live / Biber / `.bbl` 形式との互換性を個別に確認してください。

### 6.3 arXiv用zipの作り方

投稿用には、原稿処理に必要なファイルだけを別フォルダにコピーしてzip化します。例えば次のようにします。

```text
arxiv_submission/
├─ main.tex
├─ refs.bib
├─ main.bbl              # 必要に応じて同梱
└─ figures/
   ├─ figure1.pdf
   └─ figure2.pdf
```

含めないものの例は以下です。

```text
out/
*.aux
*.log
*.fls
*.fdb_latexmk
*.synctex.gz
diff.tex
diff.pdf
README.md
makefile
.vscode/
```

ただし、カスタム `.sty`、`.cls`、`bst` ファイルを使っており、arXiv側に存在しない可能性がある場合は、それらを投稿アーカイブに含めます。

### 6.4 arXiv投稿時の流れ

一般的な流れは次の通りです。

1. arXivにログインする。
2. `Start new submission` を選ぶ。
3. 分野カテゴリーを選択する。宇宙論の場合は内容に応じて `astro-ph.CO`、`gr-qc`、`hep-th` などを検討する。
4. タイトル、Abstract、著者、コメント、MSC/PACS等、必要なメタデータを入力する。
5. ソースファイルのzipをアップロードする。
6. arXiv側でTeX処理を行い、生成PDFを確認する。
7. ローカルPDFとarXiv生成PDFの見た目、図表、参考文献、数式番号を確認する。
8. 問題がなければ最終確認を行い、投稿を確定する。

arXivでは投稿確定時刻や公開スケジュールが決まっているため、締切直前の投稿は避け、PDF生成結果を確認する時間を残してください。

### 6.5 arXiv replacement

公開済み原稿を差し替える場合は、arXivのユーザーページから対象論文の `Replace` を選び、新しいソース一式をアップロードします。差し替え時には、変更内容を簡潔に説明するコメントを用意します。

例：

```text
Revised version. Added discussion of recent observational constraints, clarified the model-selection procedure, and corrected typographical errors. Conclusions unchanged.
```

大幅改訂の場合は、本文のどこが変わったかをローカルで把握するために、後述の `latexdiff` による差分PDFを作成して確認することを推奨します。

## 8. ジャーナル投稿用の準備

### 7.1 投稿前チェック

ジャーナル投稿前には、arXiv投稿時の確認に加え、以下を確認します。

- 投稿先ジャーナルがREVTeXを受け付けるか。
- `preprint`、`reprint`、行番号、図表の別ファイル提出など、投稿形式の指定があるか。
- Abstractの文字数制限があるか。
- Keywords、PACS、MSC、JEL等の指定があるか。
- Cover letter が必要か。
- Suggest reviewers / Opposed reviewers の入力欄があるか。
- arXiv ID、ORCID、Funding information、Conflict of interest、Data availability statement 等の入力が必要か。
- Figure source file、Graphical abstract、Supplementary material の扱いに指定があるか。

投稿先によっては、初回投稿ではPDFのみでよく、採択後にTeX sourceを要求する場合があります。一方で、初回からTeX source一式を要求するジャーナルもあります。必ず投稿先の最新の author guidelines を確認してください。

### 7.2 ジャーナル投稿用ファイル

典型的には、以下を準備します。

```text
manuscript.pdf          # 本文PDF
source.zip              # TeX source一式を要求される場合
cover_letter.pdf        # または投稿フォームのテキスト欄に入力
figures.zip             # 図ファイルを個別提出する場合
supplement.pdf          # 補足資料がある場合
```

ジャーナルによっては、Cover letter や Response to Referee を本文ソースのzipに含めると編集者に見えない場合があります。投稿システム上の専用欄または attachment として提出してください。

## 9. Cover letter の下書き

Cover letter は、論文の主張を売り込み過ぎず、投稿先との適合性、新規性、独立性、倫理的確認事項を簡潔に伝える文書です。長くても1ページ程度を目安にします。

以下は初回投稿用の例です。

```text

New submission to [Journal Name]
Title: "[Manuscript Title]"
arXiv:[xxxx.xxxxx] [astro-ph.CO]※[gr-gc],[hep-th]などもあり
Authors: [Authors Name]


     
We would like to sincerely appreciate your kind considerations and warm support very much.

Dear Editor(s) (Journal Name):

We would like to submit our manuscript entitled
``[Manuscript Title]'' arXiv:[xxxx.xxxxx] [astro-ph.CO] to [Journal Name].

In this paper, we [Abstract].

We would like to sincerely appreciate your kind considerations and warm support very much.

Yours sincerely,
[Authors Name]
```

投稿済みarXiv原稿がある場合は、必要に応じて次の一文を追加します。

```text
A preprint version of this manuscript is available at arXiv:[xxxx.xxxxx].
```


## 10. 査読者レポートへの回答作成

### 9.1 基本方針

査読対応では、以下を必ず分けて管理します。

1. 改訂後の本文原稿
2. 旧版と新版の差分PDF
3. 査読者コメントへの回答書
4. Cover letter または editor への説明文

査読者への回答では、すべてのコメントに番号を付け、各コメントに対して「何を変更したか」「変更箇所はどこか」「変更しなかった場合はなぜか」を明確に書きます。

### 9.2 `report.tex` の使い方

`report.tex` は査読回答書のテンプレートです。冒頭の情報を埋めます。

```tex
Manuscript reference: [Manuscript ID] \\
Title: [Title] \\
Authors: [Authors] \\
Journal: [Journal Name]
```

査読コメントを引用し、その下に回答を書きます。

```tex
\noindent {\bf 1)}
{\em ``Reviewer comment.''}
\\

\textbf{Our answer:}\\
We thank the reviewer for this helpful comment.
We have revised Sec.~II, paragraph 3, to clarify ...
The corresponding change appears on p.~4, lines 120--135 of the revised manuscript.
```

回答では、感情的な反論を避け、必要な場合でも次のように書きます。

```text
We respectfully disagree with this point for the following reason. ...
To avoid possible misunderstanding, we have added a clarifying sentence in Sec. ...
```

### 9.3 回答書の典型構成

```text
Dear Editor and Referees,

We thank the Editor and the Referees for their careful reading of our manuscript
and for their constructive comments. We have revised the manuscript accordingly.
Below, we provide a point-by-point response. Reviewer comments are shown in italic,
followed by our responses.

Response to Reviewer 1
Comment 1: ...
Response: ...

Comment 2: ...
Response: ...

Response to Reviewer 2
...

Summary of major changes:
1. ...
2. ...
3. ...

Yours sincerely,
[Name]
on behalf of all authors
```

### 9.4 改訂時のCover letter例

```text
Ref.: [Manuscript Number]
Re-submission to [Journal Name]
Title: [Manuscript Title]
Authors: [Authors Name]



Dear Professor [Editor Name] (Editor, [Journal Name]): 

       Thank you very much for your kind considerations on our manuscript entitled “[Manuscript Title]” [Ref.: [Manuscript Number]].
We would like to resubmit our revised manuscript, along with a response letter to the respected reviewer, to [Journal Name]. We are grateful to you and the respected reviewer for the constructive and insightful comments, which have significantly improved the clarity, presentation, and quality of our manuscript. In our revised version, we have tried to address all the points raised by the respected reviewer one by one very carefully as far as we can. We have also highlighted all these changes in blue for the convenience of the respected reviewer. We believe this revised manuscript addressed all concerns raised during the review process and met the publication standards of [Journal Name]. 

We would like to again sincerely appreciate your kind considerations and warm supports very much. 

Yours sincerely,

[Author Names]

```

JCAP等、一部ジャーナルでは改訂時のCover letterまたは査読回答の入力が必須であり、本文ソースアーカイブに含めても編集者に見えない場合があります。その場合は、投稿フォームのテキスト欄または attachment として提出します。

## 11. `makefile` による差分PDF作成

### 10.1 目的

`makefile` の `diff` ターゲットは、`latexdiff` を使って旧版texと新版texの差分ファイル `diff.tex` を作成し、それを `latexmk` でPDF化します。査読対応時に、編集者・査読者に変更箇所を示すPDFを作るために使います。

このテンプレートでは、`latexdiff` に次のオプションを渡します。

```makefile
LATEXDIFF_OPTS ?= --flatten --type=UNDERLINE --subtype=SAFE
```

`--flatten` は `\input` や `\include` を展開するための指定です。本文が複数ファイルに分割されている場合に有用です。

### 10.2 基本コマンド

Windowsで MinGW / TDM-GCC の `mingw32-make` を使う場合は、テンプレートのルートディレクトリで次を実行します。

```powershell
mingw32-make diff OLD=old_ver_filename.tex NEW=new_ver_filename.tex
```

具体例：

```powershell
mingw32-make diff OLD=main_revised_v2.tex NEW=main_revised_v3.tex
```

出力名を変えたい場合は `DIFF` を指定します。

```powershell
mingw32-make diff OLD=main_revised_v2.tex NEW=main_revised_v3.tex DIFF=diff_v2_v3
```

この場合、差分PDFは通常 `out/diff_v2_v3.pdf` に生成されます。

### 10.3 ヘルプ表示

```powershell
mingw32-make help
```

表示内容：

```text
Usage:
  mingw32-make diff OLD=main_revised_v2.tex NEW=main_revised_v3.tex

Variables:
  OLD    old LaTeX source
  NEW    new LaTeX source
  DIFF   diff output basename, default: diff
  OUTDIR output directory, default: out
```

### 10.4 差分関連ファイルの削除

差分texと補助ファイルのみ削除する場合：

```powershell
mingw32-make clean
```

差分PDFも含めて削除する場合：

```powershell
mingw32-make distclean
```

### 10.5 よくあるエラー

#### `mingw32-make: command not found`

MinGW / TDM-GCC がインストールされていない、またはPATHが通っていません。`mingw32-make.exe` の場所をPATHに追加してください。

#### `latexdiff: command not found`

`latexdiff` がインストールされていない、またはPATHが通っていません。TeX Liveの場合は `tlmgr`、MiKTeXの場合は MiKTeX Console から導入してください。

#### `No rule to make target 'diff'`

`makefile` があるディレクトリでコマンドを実行していない可能性があります。`main.tex` と `makefile` があるテンプレートのルートディレクトリに移動してから実行してください。

#### 差分PDFのコンパイルに失敗する

`latexdiff` は複雑な数式、独自マクロ、図表、コメントアウトされた環境に弱い場合があります。その場合は以下を試します。

- 旧版・新版の両方が単独でコンパイルできることを確認する。
- 差分を取りたい範囲以外の大きな表や図を一時的に簡略化する。
- 独自マクロをプリアンブルに明示する。
- `LATEXDIFF_OPTS` を変更する。

例：

```powershell
mingw32-make diff OLD=old.tex NEW=new.tex LATEXDIFF_OPTS="--flatten --type=CFONT"
```

## 12. 推奨する執筆・投稿ワークフロー

### 11.1 初稿作成

1. `main.tex` のタイトル、著者、所属、Abstractを埋める。
2. Introductionで研究背景、先行研究、未解決点、本研究の目的を明確に書く。
3. Method / Model で仮定、方程式、データ、解析手順を定義する。
4. Resultsで図表と定量結果を提示する。
5. Discussion / Conclusionで結果の意味、限界、今後の課題を整理する。
6. `refs.bib` を整備する。
7. `latexmk main.tex` でビルドし、警告とPDFを確認する。

### 11.2 共著者確認

1. 共有用PDFを作成する。
2. ファイル名に日付または版番号を付ける。
3. 共著者コメントを反映したら、旧版を残したまま新版を作る。
4. 必要に応じて `latexdiff` で変更箇所を確認する。

例：

```text
main_v1.tex
main_v2.tex
main_v3.tex
```

差分確認：

```powershell
mingw32-make diff OLD=main_v2.tex NEW=main_v3.tex DIFF=diff_v2_v3
```

### 11.3 arXiv投稿

1. 投稿用フォルダを作る。
2. 必要な `.tex`、`.bib`、必要なら `.bbl`、図ファイルだけをコピーする。
3. 不要な補助ファイルや差分PDFを除外する。
4. arXivでソースをアップロードする。
5. arXiv生成PDFを確認する。
6. 問題がなければ投稿を確定する。

### 11.4 ジャーナル投稿

1. 投稿先の author guidelines を確認する。
2. PDF、source zip、Cover letter、Supplementary material を準備する。
3. 投稿システムにメタデータを入力する。
4. 推薦査読者や除外査読者が必要なら準備する。
5. 最終確認PDFをダウンロードし、図表・参考文献・数式番号を確認する。
6. 投稿を確定する。

### 11.5 査読対応

1. Referee report を保存する。
2. コメントを番号付きで分解する。
3. 本文修正が必要なコメントと、回答のみでよいコメントを分ける。
4. 本文を修正する。
5. `latexdiff` で差分PDFを作成する。
6. `report.tex` で点ごとの回答書を作成する。
7. 改訂版本文PDF、差分PDF、回答書、Cover letterを提出する。

## 13. 投稿前チェックリスト

### 本文

- [ ] タイトルが投稿先の範囲と合っている。
- [ ] Abstractが結果と結論を過不足なく述べている。
- [ ] Introductionで研究目的と新規性が明確である。
- [ ] すべての記号が初出時に定義されている。
- [ ] 図表が本文中で参照されている。
- [ ] 数式番号・図番号・表番号が崩れていない。
- [ ] Conclusionが本文で示した結果を超えて過剰に主張していない。

### 参考文献

- [ ] すべての引用キーが解決されている。
- [ ] DOI、arXiv番号、雑誌名、巻、ページ、年が正しい。
- [ ] 重要な先行研究が抜けていない。
- [ ] 引用していない文献が不必要に残っていない。

### 技術面

- [ ] `latexmk main.tex` がエラーなしで完了する。
- [ ] `out/main.pdf` を最初から最後まで確認した。
- [ ] 図ファイルのパスと大文字小文字が一致している。
- [ ] 投稿用zipに不要ファイルが含まれていない。
- [ ] arXivまたはジャーナル投稿システムで生成されたPDFを確認した。

### 査読対応

- [ ] すべての査読コメントに回答している。
- [ ] 修正箇所のページ・行・節番号を示している。
- [ ] 反論がある場合も丁寧かつ論理的に説明している。
- [ ] 差分PDFを作成した。
- [ ] Cover letter と response letter を本文アーカイブではなく適切な提出欄に入れた。

## 14. 運用上の注意

- このテンプレートは汎用的なREVTeXテンプレートです。最終的には投稿先ジャーナルの最新指示を優先してください。
- arXivやジャーナルの投稿システムは更新されるため、投稿直前に公式ページを確認してください。
- ローカルで生成したPDFと投稿システムで生成されたPDFが一致するとは限りません。必ず投稿システム側のPDFを確認してください。
- Windowsでは大文字小文字の違いが見逃されやすいですが、投稿システムでは区別される場合があります。
- 差分PDFは査読者の確認を助けるための資料であり、本文PDF・回答書の代替ではありません。

## 15. 参考リンク

- REVTeX 4.2: https://journals.aps.org/revtex
- MacTeX: https://tug.org/mactex/
- TeX Live: https://tug.org/texlive/
- MiKTeX: https://miktex.org/
- CTAN revtex package: https://ctan.org/pkg/revtex
- arXiv Submission Guidelines: https://info.arxiv.org/help/submit/index.html
- arXiv Submit TeX/LaTeX: https://info.arxiv.org/help/submit_tex.html
- arXiv TeX Live information: https://info.arxiv.org/help/faq/texlive.html
- arXiv replacement help: https://info.arxiv.org/help/replace.html
- arXiv 00README format: https://info.arxiv.org/help/00README.html
- JCAP author help: https://jcap.sissa.it/jcap/help/helpLoader.jsp?pgType=author
