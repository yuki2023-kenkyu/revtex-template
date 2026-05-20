# Cover letter templates using `academiccoverletter.sty`

このディレクトリには、新規投稿用Cover letterと、査読回答・改訂再投稿時のCover letterを共通の設定ファイルで管理するテンプレートを含めています。

対象ファイルは以下です。

```text
academiccoverletter.sty          # 体裁・文章構造・共通マクロを定義する共通スタイルファイル
cover_letter_new_submission.tex  # 新規投稿用Cover letterの本文ファイル
cover_letter_resubmission.tex    # 改訂再投稿・査読回答送付用Cover letterの本文ファイル
```

基本方針は、フォント、余白、行間、インデント、見出しサイズ、ヘッダーと本文の間隔などの「見た目と文章構造」は `academiccoverletter.sty` に集約し、投稿ごとに変える「論文情報」は各 `cover_letter_*.tex` に置くことです。

## 1. 使い方

新規投稿用Cover letterは次でコンパイルします。

```bash
latex cover_letter_new_submission.tex
```

査読回答・改訂再投稿用Cover letterは次でコンパイルします。

```bash
latex cover_letter_resubmission.tex
```

Times New Romanに近い体裁を再現するため、推奨コンパイラはLuaLaTeXです。LuaLaTeXまたはXeLaTeXの場合、Windows/macOSにTimes New Romanがあればそれを使います。見つからない場合はTeX Gyre Termes、さらに見つからない場合はLiberation Serifへフォールバックします。

pdfLaTeXでもコンパイルできるようにしてありますが、その場合は `newtxtext` / `newtxmath` によるTimes系フォントになります。

## 2. 投稿ごとに編集する場所

通常は `academiccoverletter.sty` ではなく、各 `cover_letter_*.tex` の設定ブロックのみを編集します。

### 2.1 新規投稿用 `cover_letter_new_submission.tex`

編集対象は主に次です。

| マクロ | 意味 | 例 |
|---|---|---|
| `\CLSubmissionType` | 投稿種別 | `New submission` |
| `\CLJournalName` | ジャーナル正式名 | `Journal of Cosmology and Astroparticle Physics` |
| `\CLJournalShortName` | 略称。空にすると表示されない | `JCAP` |
| `\CLEditorName` | Editor名。空にすると `Dear Editor(s)` になる | 空欄または `Professor ...` |
| `\CLEditorRole` | Editorの役職表示 | `Editor` |
| `\CLManuscriptTitle` | 論文タイトル | `Testing \ensuremath{\Lambda}CDM ...` |
| `\CLArxivID` | arXiv ID。空にするとarXiv行と本文中のarXiv表記が消える | `2604.22372` |
| `\CLArxivCategory` | arXivカテゴリ。空にするとカテゴリだけ表示されない | `astro-ph.CO` |
| `\CLAuthorNames` | 署名・著者欄に使う著者名 | `Yuki Hashimoto, ...` |
| `\CLManuscriptSummary` | 論文内容の説明段落 | 投稿先に合わせて編集 |
| `\CLNewSubmissionClosingSentence` | 結びの一文 | `We would like to sincerely appreciate ...` |

arXiv IDを表示しない場合は次のように空にします。

```tex
\renewcommand{\CLArxivID}{}
\renewcommand{\CLArxivCategory}{}
```

Editor名を指定しない場合は、宛名は自動的に次の形になります。

```text
Dear Editor(s) (Journal Name):
```

Editor名を指定した場合は、次の形になります。

```text
Dear Professor X (Editor, Journal Name):
```

### 2.2 改訂再投稿用 `cover_letter_resubmission.tex`

編集対象は主に次です。

| マクロ | 意味 | 例 |
|---|---|---|
| `\CLReferenceNumber` | 投稿管理番号。空にすると `Ref.: ...` が消える | `IJMPD6984` |
| `\CLSubmissionType` | 投稿種別 | `Re-submission` |
| `\CLJournalName` | ジャーナル正式名 | `International Journal of Modern Physics D` |
| `\CLJournalShortName` | 略称 | `IJMPD` |
| `\CLEditorName` | Editor名 | `Professor Parampreet Singh` |
| `\CLEditorRole` | Editorの役職表示 | `Editor` |
| `\CLManuscriptTitle` | 論文タイトル | 改訂投稿する論文のタイトル |
| `\CLArxivID` | arXiv ID。不要なら空 | 空欄またはarXiv ID |
| `\CLAuthorNames` | 署名・著者欄に使う著者名 | `Yuki Hashimoto, ...` |
| `\CLReviewerDisplay` | 査読者の呼び方 | `the respected reviewer` / `the reviewers` |
| `\CLResponseLetterName` | 同封する回答書の表現 | `a response letter to \CLReviewerDisplay` |
| `\CLChangeHighlightDescription` | 修正箇所の色や表示方法。空にすると該当文が消える | `blue` |
| `\CLResubmissionClosingSentence` | 結びの一文 | `We would like to again sincerely appreciate ...` |

修正箇所を色で強調していない場合は、次のように空にします。

```tex
\renewcommand{\CLChangeHighlightDescription}{}
```

この場合、次の文は自動的に出力されません。

```text
We have also highlighted all these changes in blue ...
```

複数の査読者に対する回答の場合は、例えば次のようにできます。

```tex
\renewcommand{\CLReviewerDisplay}{the reviewers}
\renewcommand{\CLResponseLetterName}{a point-by-point response letter to the reviewers}
```

## 3. 体裁を変更する場所

フォント、余白、インデント、行間、見出しサイズ、縦方向スペースなどは `academiccoverletter.sty` 冒頭の `Layout settings` ブロックで変更します。

### 3.1 余白

```tex
\setlength{\CLTopMargin}{35mm}
\setlength{\CLBottomMargin}{30mm}
\setlength{\CLLeftMargin}{30mm}
\setlength{\CLRightMargin}{30mm}
```

| 設定 | 変わる場所 | 大きくした場合 |
|---|---|---|
| `\CLTopMargin` | ページ上余白 | 本文全体が下がる |
| `\CLBottomMargin` | ページ下余白 | 下側の使用可能領域が狭くなる |
| `\CLLeftMargin` | 左余白 | 文章ブロックが右へ寄る |
| `\CLRightMargin` | 右余白 | 文章ブロックの右端が左へ寄る |

余白は `geometry` パッケージで設定しています。`academiccoverletter.sty` 内の数値を変更するのが最も安全です。本文側の `.tex` で後から余白だけ変えたい場合は、単に `\setlength{\CLTopMargin}{...}` と書くだけではなく、次のように `\geometry{...}` を再実行してください。

```tex
\geometry{top=32mm,bottom=28mm,left=28mm,right=28mm}
```

### 3.2 段落インデント

```tex
\setlength{\CLParagraphIndent}{16mm}
```

本文段落の字下げ量を指定します。大きくすると段落冒頭が右に深く入ります。Wordファイルに近い字下げを再現したい場合は、`14mm` から `20mm` 程度で調整します。字下げをなくす場合は次のようにします。

```tex
\setlength{\CLParagraphIndent}{0mm}
```

### 3.3 ヘッダーから宛名までの間隔

```tex
\setlength{\CLMetadataAfterSpace}{27mm}
```

タイトル、投稿種別、論文タイトル、著者名などのメタデータ欄と、`Dear Editor(s)` などの宛名との縦方向スペースを指定します。大きくすると宛名が下に移動します。

### 3.4 宛名から本文までの間隔

```tex
\setlength{\CLGreetingAfterSpace}{7mm}
```

`Dear ...:` と本文第1段落の間隔です。大きくすると本文が下がります。

### 3.5 段落間の間隔

```tex
\setlength{\CLParagraphAfterSpace}{5mm}
```

本文段落間、結び、署名前後の基本的な縦方向スペースです。Word文書に近い余白感を出すには `4mm` から `7mm` 程度で調整します。

### 3.6 署名前の間隔

```tex
\setlength{\CLSignatureAfterSpace}{5mm}
```

`Yours sincerely,` と著者名の間隔です。手書き署名欄を広く取りたい場合は、この値を大きくします。

### 3.7 見出しサイズ

```tex
\newcommand{\CLTitleFontSize}{18pt}
\newcommand{\CLTitleLineSkip}{22pt}
\newcommand{\CLTitleAfterSpace}{2mm}
```

| 設定 | 意味 |
|---|---|
| `\CLTitleFontSize` | `Cover Letter` 見出しのフォントサイズ |
| `\CLTitleLineSkip` | 見出し行の行送り |
| `\CLTitleAfterSpace` | 見出し直後の縦方向スペース |

見出しをWordファイルより控えめにしたい場合は、例えば次のようにします。

```tex
\newcommand{\CLTitleFontSize}{16pt}
\newcommand{\CLTitleLineSkip}{20pt}
```

### 3.8 フォント

```tex
\newcommand{\CLMainFont}{Times New Roman}
\newcommand{\CLFallbackFontA}{TeX Gyre Termes}
\newcommand{\CLFallbackFontB}{Liberation Serif}
```

LuaLaTeXまたはXeLaTeXでコンパイルした場合、最初に `Times New Roman` を探します。見つからない場合は `TeX Gyre Termes`、さらに見つからない場合は `Liberation Serif` を使います。

本文全体を別フォントにしたい場合は、`\CLMainFont` を変更してください。例えばLinux環境でTeX Gyre Termesに固定する場合は次のようにします。

```tex
\newcommand{\CLMainFont}{TeX Gyre Termes}
```

既に `\newcommand{\CLMainFont}{...}` があるため、変更時はその行を書き換えてください。

### 3.9 ハイフネーションと行のはみ出し対策

```tex
\newcommand{\CLEmergencyStretch}{2em}
\newcommand{\CLHyphenPenalty}{10000}
\newcommand{\CLExHyphenPenalty}{10000}
```

このテンプレートでは、Word文書に近い見た目を優先し、英単語の自動ハイフネーションを強く抑制しています。長いタイトルやURLがある場合に行がはみ出すときは、`\CLEmergencyStretch` を大きくするか、タイトル内に手動改行・短縮表記を入れてください。

## 4. 文章構造を変更したい場合

文章構造そのものは `academiccoverletter.sty` の末尾にある次の2つのコマンドで定義しています。

```tex
\CLMakeNewSubmissionLetter
\CLMakeResubmissionLetter
```

新規投稿用の文章順序は次です。

1. `Cover Letter` 見出し
2. 投稿種別、投稿先、タイトル、arXiv、著者
3. 宛名
4. 投稿する旨の第1段落
5. 研究内容の要約段落 `\CLManuscriptSummary`
6. 結びの一文 `\CLNewSubmissionClosingSentence`
7. `Yours sincerely,`
8. 著者名 `\CLAuthorNames`

改訂再投稿用の文章順序は次です。

1. `Cover Letter` 見出し
2. Ref.番号、投稿種別、投稿先、タイトル、arXiv、著者
3. 宛名
4. 論文を検討してもらったことへの謝辞
5. 改訂原稿と回答書を再提出する旨
6. 査読者コメントへの謝辞
7. 点ごとに対応した旨
8. 修正箇所の強調表示に関する文。`\CLChangeHighlightDescription` が空なら省略
9. 掲載基準を満たすと考える旨
10. 結びの一文 `\CLResubmissionClosingSentence`
11. `Yours sincerely,`
12. 著者名 `\CLAuthorNames`

文章構造を大きく変えたい場合は、`academiccoverletter.sty` 内の `\CLMakeNewSubmissionLetter` または `\CLMakeResubmissionLetter` を編集します。投稿ごとに文面だけを少し変えたい場合は、`.sty` ではなく各 `cover_letter_*.tex` で `\CLManuscriptSummary`、`\CLNewSubmissionClosingSentence`、`\CLReviewerDisplay`、`\CLResponseLetterName`、`\CLResubmissionClosingSentence` などを変更する方が安全です。

## 5. よくある調整例

### 5.1 全体を少し上に詰める

`academiccoverletter.sty` で次を小さくします。

```tex
\setlength{\CLTopMargin}{30mm}
\setlength{\CLMetadataAfterSpace}{22mm}
```

### 5.2 段落間の余白をWord文書より詰める

```tex
\setlength{\CLParagraphAfterSpace}{3mm}
```

### 5.3 インデントを浅くする

```tex
\setlength{\CLParagraphIndent}{10mm}
```

### 5.4 JCAPなどでEditor名を指定せず投稿する

```tex
\renewcommand{\CLEditorName}{}
```

この場合、宛名は `Dear Editor(s) (...)` になります。

### 5.5 IJMPDなどでEditor名を明示する

```tex
\renewcommand{\CLEditorName}{Professor Parampreet Singh}
\renewcommand{\CLEditorRole}{Editor}
```

### 5.6 arXiv IDを本文中に入れない

```tex
\renewcommand{\CLArxivID}{}
\renewcommand{\CLArxivCategory}{}
```

### 5.7 修正箇所の色表示文を消す

```tex
\renewcommand{\CLChangeHighlightDescription}{}
```

### 5.8 修正箇所を赤で示したことにする

```tex
\renewcommand{\CLChangeHighlightDescription}{red}
```

## 6. 注意点

- 投稿先によってはCover letterをPDFでアップロードするのではなく、投稿システムのテキスト欄に直接入力する場合があります。その場合でも、このTeXテンプレートで文面を作成し、PDFまたは生成テキストを確認してから転記できます。
- Cover letterには、通常、査読回答の詳細を長く書きません。詳細な回答は `report.tex` または別のresponse letterに分けます。
- `.sty` ファイルは体裁と共通文章構造を管理するファイルとして使っています。投稿ごとの論文情報は原則として `.tex` 側に置いてください。
- arXiv ID、Ref.番号、Editor名などを空にした場合に不要な行や文が消えるようにしていますが、最終PDFでは必ず空白や句読点の崩れを確認してください。
