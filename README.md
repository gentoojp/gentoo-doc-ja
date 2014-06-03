# Gentoo ドキュメント日本語翻訳リポジトリ

このリポジトリはGentooの公式ドキュメントの日本語翻訳用リポジトリです。
このリポジトリで翻訳を行なっています。

このドキュメントでは以下の項目について記載します。

- 翻訳を始める
- 翻訳の注意点
- 翻訳のレビュー
- 翻訳のコミット
- 翻訳の更新
- 翻訳ミスを見つけたら
- 困ったことがあったら

## 翻訳を始める

### 翻訳の流れ

翻訳作業は以下のような流れで行なわれます。

- 翻訳対象を選択
- 翻訳の宣言
- 翻訳用ブランチの作成
- .poファイルの編集
- GitHubへのpushとPull Request
- レビューをうけて更新
- 翻訳完了: 本家へのコミット

### 翻訳するファイルを選ぶ

基本的にお好みのどのファイルでも構いません。翻訳が古いものを見つけてそ
れを翻訳してみてください。

どのファイルが古いのかを見るには
[ドキュメント開発状況一覧](http://www.gentoo.org/doc/ja/overview.xml)
が便利です。 「3.  ファイル」のリストの「オリジナルバージョン」が赤くなっ
ているものは、日本語翻訳があり、なおかつ翻訳が追い付いていないものです。
この中でも特に "/doc/ja/handbook/handbook-amd64.xml" と
"/doc/ja/handbook/handbook-x86.xml" および "/doc/ja/handbook/hb-" から
始まるファイルは優先して更新したいファイルです。

### 翻訳状況の確認と登録

実際に翻訳を始める前に
[Issues](https://github.com/gentoojp/gentoo-doc-ja/issues?labels=translation&page=1&state=open)
を見て、すでにそのファイルの翻訳が開始されていないかを確認してください。
Issueのタイトルは"<ファイル名>: なんたらかんたら"となっていることが多い
ので、その部分を見てください。たとえば
"/doc/ja/handbook/hb-install-bootconfig.xml" であれば、
"hb-install-bootconfig: Update translation" というようなタイトルが付い
ているはずです。

他に翻訳している人がいないようであれば、自分が翻訳を開始することを
Issueを作ってわかるようにしておきましょう。タイトルを"<ファイル名>:
Update translation"といったように付けます。たとえば
"/doc/ja/handbook/hb-install-bootconfig.xml" であれば
"hb-install-bootconfig: Update translation" というように付けてください。
また、ラベルに "translation"を付け、可能であれば自分を assignしておくと
後々わかりくなります。

### 翻訳の準備

翻訳作業を始める前に(まだしていなければ) gentoojp/gentoo-doc-jaリポジト
リを cloneしてください。手元に cloneができたら、ファイル名に対応するブ
ランチ名でブランチを作ってください。たとえば
"/doc/ja/handbook/hb-install-bootconfig.xml" の翻訳であれば以下のような
コマンドで"hb-install-bootconfig"というブランチを作ることができます。

```ShellSession
$ cd gentoo-doc-ja
$ git checkout master && git pull origin master
$ git checkout -b hb-install-bootconfig
```

### 翻訳する

翻訳作業は".poファイル"という形式のファイルを編集することで行なわれます。
".poファイル"は主に "xml/htdocs/doc/pofiles/" 下に置かれています。たと
えば "/doc/ja/handbook/hb-install-bootconfig.xml" に対応するファイルは
"xml/htdocs/doc/pofiles/handbook/hb-install-bootconfig.po" となります。

新しいファイルの翻訳を始めたら、まずは*ファイル冒頭のメタデータを編集す
るようにしてください。* "Po-Revision-Date" に編集日時を、
"Last-Translator" にあなたの名前と可能ならばメールアドレスを記載してく
ださい。

```Gettext Catalog
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: PACKAGE VERSION\n"
"POT-Creation-Date: 2013-01-25 08:06+0900\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"Language: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
```

".poファイル"は原文の文書を、ある程度の文章の塊ごとに翻訳するようにでき
ています。.poファイルの中身には原文であるmsgidと、それに対応する翻訳で
あるmsgstr、そして"#"で始まるメタデータやコメントが以下のように並んでい
ます。これらを確認し、fuzzyタグを取り除き、未翻訳の項目をなくすのが翻訳
のゴールです。

多くの項目は"fuzzyタグ"("#," で始まる行)が付いた以下のような形となって
います。現在の翻訳を確認して、英語と合わないところがあれば修正してくだ
さい。この時 *"fuzzy" を取らないように注意してください。*

```Gettext Catalog
#. type: Content of: <included><section><title>
#: en/handbook/hb-install-bootconfig.xml:11
#, fuzzy, no-wrap
msgid "Extra Hardware Configuration"
msgstr "特別なハードウェアの構成"
```

中にはmsgstrが空のものもあります。この項目は「未翻訳」のものです。
msgidの原文に対応する翻訳を考えて、msgstrに記載してください。 msgstrか
らコピーする時は、*「"」のエスケープに気をつけてください。* また、翻訳
後に上記のような*"fuzzyタグ"を付けるのを忘れないでください。*

```Gettext Catalog
#. type: Content of: <sections><section><subsection><body><p>
#: en/handbook/hb-install-about.xml:146
#, no-wrap
msgid ""
"We also provide a <uri link=\"https://wiki.gentoo.org/wiki/Gentoo_installation_tips_and_tricks\">Gentoo\n"
"Installation Tips &amp; Tricks</uri> document that might be useful to read as\n"
"well. \n"
msgstr ""
```

場合によっては"#~"で始まる以下のような項目がファイル末尾に並んでいるこ
とがあります。これはすでに無くなってしまった、以前の文章を翻訳の更新時
の参考になるように残しているものです。これは翻訳更新後にはいらないもの
ですので、*削除してください。*

```Gettext Catalog
#, fuzzy
#~ msgid "Now you have your Gentoo system, but what's next? \n"
#~ msgstr "Gentooシステムは完成しましたが、次は何をすればいいのでしょう？\n"
```

### 編集ソフト

".poファイル"を手で編集するのはなかなか骨が折れる作業です。このファイル
を編集する手助けとなるソフトがいくつもあります。参考に簡単なソフト一覧
と誰がそのソフトを使っているのかを書いておきます。

- app-emacs/po-mode
    - naota
- app-i18n/poedit
- app-text/granslator

### GitHubへのpushとPull Request

一通り翻訳作業が終わったら、作業をcommitし、GitHubにpushしてレビューを
受けます。この時commit logに"Fix #3"のようにissue番号を書いておくと便利
です。push先はgentoojp/gentoo-doc-jaリポジトリで構いません。もしpushで
きなければ、後述の「困ったことがあったら」を参考にGentooJPのメンバーに
連絡をとってみてください。

pushが完了したらPull Requestを作ってください。検索しやすいように、でき
たPull Requestに "translation"と"NeedReview"のラベルを付けておいてくだ
さい。

しばらくすると誰かがレビューを行なってくれるはずです。もししばらくして
も反応がなかったら? 「困ったことがあったら」を参考につっついてみてくだ
さい ^^;

レビュー者は以下のようにfuzzyタグを取り除き、またコメントを書いてくれま
す。 fuzzyタグがまだ残っている項目をコメントを参考に修正、またはコメン
トに返信してください。この時*コメントは次のレビューの時のために残してお
くようにしてください。*

```Gettext Catalog
#  問題無いと思います。
#. type: Content of: <sections><section><title>
#: en/handbook/hb-install-system.xml:21
#, no-wrap
msgid "Chrooting"
msgstr "chrootする"

# naota: ここも「複数」でしょうか
#. type: Content of: <sections><section><subsection><body><p>
#: en/handbook/hb-install-config.xml:370
#, fuzzy, no-wrap
msgid ""
"If you have several network interfaces, you need to create the appropriate\n"
"<path>net.*</path> files just like you did with <path>net.eth0</path>.\n"
msgstr ""
"もしいくつかのネットワークインターフェイスがあるなら、<path>net.eth0</path>の時と同様に\n"
"適切な<path>net.*</path>を作成する必要があります。\n"
```

修正作業が終わればふたたびpushしてください。pushした旨をissueにコメント
して、 "NeedReview"ラベルを付けてください。以前にレビューした人に
assignしておくのもいいかもしれません。

### 翻訳完了

fuzzyタグが全てなくなり、未翻訳の項目もなくなれば翻訳は完了です。 レ
ビュー者が "CommitReady" ラベルを付けて、Gentoo本家へのコミット権を持っ
ている開発者(いまのところ naotaのみ)に assignしているはずですが忘れてい
るようでしたら付けてあげてください。数日中に本家にコミットされ、マージ
が行なわれるかと思います。翻訳おつかれさまでした。

### 翻訳途中の本家の更新

タイミングによっては翻訳をしている最中に、本家のドキュメントが更新され
てしまうこともあります。その場合、本家のドキュメントを反映した開発者か
らissueに「mergeするように」といったコメントが付くかと思います。その場
合、たとえば以下のようにして本家の更新を反映するようにしてください。

```ShellSession
$ git merge origin master
```

この時マージコンフリクトが起きる場合がありますが、適宜マージするように
してください。うまくいかない・わからない場合は後述の「困ったことがあっ
たら」を参考に連絡してください。

## 翻訳の注意点

Gentooドキュメントの翻訳に関していくつかルールがあります。

### 基本ルール

- 翻訳する単語に当てはまったとしても、コマンド名、アプリケーション名、
  パッケージ名の場合は、英文のまま記述する。
- 英文内では、大文字、小文字が統一性無く使われていることがあるが、「英
  単語のまま記述するもの」のリストにあるものについては、この通り記述する
    - (例、"portage"=>"Portage")。
- 英単語の前後に空白を入れない。
- 「全て」→「すべて」、「出来ます」→「できます」で統一
- 文と文をつなげる「:」があり、意味的に不必要な場合は削除するよう訳を修
  正する。

### Handbookローカルのルール

単語         | 翻訳           | 説明
------------ | -------------- | ---------------------------------------------------------------
Default      | 一般的な選択   | 一般的な人に当てはまるだろうと筆者が考えている選択。強制でない。
Alternative  | もう一つの選択 | Default以外の選択
Optional     | 任意自由選択   | やってもやらなくてもいいこと

### 翻訳せずにそのまま英単語で記述するもの

- ebuild
- Gentoo
- Linux
- Portage
- stage
- tarball

### 翻訳する単語

単語          | 翻訳
------------- | --------------
architecture  | アーキテクチャ
DEPEND atom   | DEPENDアトム
kernel        | カーネル
partition     | パーティション
permission(s) | パーミッション
reboot        | リブート
synbolic link | シンボリックリンク
symlink       | シンボリックリンク
USE flag      | USEフラグ

### 略語・俗語

単語 | 翻訳
---- | ------------
box  | コンピュータ

## 翻訳のレビュー

このセクションでは翻訳のレビュー方法について解説します。翻訳が終わって
もレビューが付かないことにはコミットできません。レビューも翻訳同様に大
事なステップです。

レビューが必要なPull Requestには"NeedReview"というラベルが付いています。
[Issuesから検索](https://github.com/gentoojp/gentoo-doc-ja/issues?labels=NeedReview&page=1&state=open)
し、レビューするPull Requestを見つけます。 Pull Requestのタイトルに翻訳
対称のファイル名が書いているので、そのタイトルを見るか、あるいはコミッ
トを見て対象の.poファイルを見つけます。レビュー者もこの.poファイルを編
集することでレビューを行ないます。

レビュー者の仕事は以下の2つです。

- OKな項目のfuzzyタグを取り除くこと
- NGな項目にコメントを書くこと

翻訳後の.poファイルにはfuzzyタグが残った項目がたくさんあります。レビュー
者は fuzzyタグの残っている項目の翻訳をチェックし、OKだと思えばfuzzyタグ
を削除します。

```Gettext Catalog
#. type: Content of: <included><section><body><pre>
#: en/handbook/hb-install-bootconfig.xml:121
#, fuzzy, no-wrap
msgid "# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
msgstr ""
"# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
"<comment>(日本語訳は http://www.gentoo.org/doc/ja/handbook/<keyval id=\"online-book\"/>)</comment>\n"
```

これを以下のようにして、fuzzyタグを取り除きます。

```Gettext Catalog
#. type: Content of: <included><section><body><pre>
#: en/handbook/hb-install-bootconfig.xml:121
#, no-wrap
msgid "# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
msgstr ""
"# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
"<comment>(日本語訳は http://www.gentoo.org/doc/ja/handbook/<keyval id=\"online-book\"/>)</comment>\n"
```

または、翻訳に誤りや不明瞭な点があると感じればコメントを書きます。たと
えば以下のようにコメントを書きます。この時 *fuzzyタグをとらないように注
意してください。*

```Gettext Catalog
#  naota: 日本語訳も"en"となっていますが、"ja"では?
#. type: Content of: <included><section><body><pre>
#: en/handbook/hb-install-bootconfig.xml:121
#, fuzzy, no-wrap
msgid "# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
msgstr ""
"# <i>links http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/></i>\n"
"<comment>(日本語訳は http://www.gentoo.org/doc/en/handbook/<keyval id=\"online-book\"/>)</comment>\n"
```

また、fuzzy以外にも以下の2点を確認するようにしてください。

- 未翻訳の項目
- ファイル冒頭のメタデータ

未翻訳の項目は以下のようにmsgidが空になっています。
"en/handbook/hb-install-about.xml:146"が未翻訳ですよ、といった指摘を
issueでのコメントでしてあげてください。(.poの中にコメントしても見すごさ
れる可能性が高いと思います) この時にfuzzyタグを付けてあげるのもいいかも
しれません。

```Gettext Catalog
#. type: Content of: <sections><section><subsection><body><p>
#: en/handbook/hb-install-about.xml:146
#, no-wrap
msgid ""
"We also provide a <uri link=\"https://wiki.gentoo.org/wiki/Gentoo_installation_tips_and_tricks\">Gentoo\n"
"Installation Tips &amp; Tricks</uri> document that might be useful to read as\n"
"well. \n"
msgstr ""
```

ファイル冒頭には以下のようなメタデータが記載されています。
PO-Revision-Date が更新されているか、 Last-Translator が更新されている
かを確認してください。この部分も確認が終われば fuzzyタグを取ってあげて
ください。

```Gettext Catalog
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: PACKAGE VERSION\n"
"POT-Creation-Date: 2013-01-25 08:06+0900\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"Language: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
```

一通りレビューが終われば、GitHubにpushします。pushの方法については上記
の「GitHubへのpushとPull Request」を参考にしてください。fuzzyタグがまだ
残っている場合は、 "NeedReview"のラベルを外して翻訳者を assignしてくだ
さい。 fuzzyタグがなくなっていれば、 "CommitReady"のラベルを付けて本家
へのコミット権限を持った開発者(いまのところ naotaのみ)に assignしてくだ
さい。レビューした旨のコメントも書いておくといいかもしれません。

しばらくすると、翻訳者がコメントを反映したコミットをpushしてくるかと思
います。再度レビューをお願いします。

基本的にレビューは.poファイルの変更で行ないますが、手元で編集するのが面
倒なほど少しの変更であれば GitHubでコミットにコメントを残す形でのレビュー
でもよいかもしれません。このへんはお好みでどうぞ。

## 翻訳のコミット

翻訳およびレビューが完了したファイルから日本語のXMLファイルを生成し、本
家CVSへのコミットを行なう作業です。作業対称のPull Requestには
"CommitReady"のラベルが付いています。以下の流れで作業を行ないます。

- makeコマンドによる日本語XMLの生成
- 生成された日本語XMLファイルの微調整
- 本家CVSへのコミット
- Gitへのコミット・ブランチへのpush
- ブランチをマージ・削除

```ShellSession
$ cd xml/htdocs/doc
$ make ja/handbook/hb-install-about.xml
...
$ edit ja/handbook/hb-install-about.xml
$ cd ja
$ cvs ci -m 'Update translation' handbook/hb-install-about.xml
$ git add handbook/hb-install-about.xml
$ git push origin hb-install-about
```

po4aの仕様上どうしてもタグの微妙な位置ずれや、translatorタグの消去など
が起きてしまう場合があります。なるべくdiffが小さくなるように微調整を行
なってください。CVSへのコミットによるCVSタグの変更がgitに反映されるよう
に、*CVSへのコミットの後にgitへのコミットを行なってください。* Pull
Requestがマージされcloseされたことがわかりやすいように、まずはpushして
GitHubの方でPull Requestをマージ・close・ブランチの削除をするのが良いと
思います。

## 翻訳の更新

翻訳したファイルにもやがてまた本家のドキュメントの更新が入ります。ここ
では本家のドキュメントの更新を反映する方法について解説します。

本家のドキュメントが更新された場合、まずその変更をCVSを使って適用します。
その後、日本語XMLの更新を試みます。場合によっては、.poファイルの更新な
しでコミットできる場合もあります。この場合は、上記を参考にCVSへのコミッ
トを行なってください。

.poファイルの更新が必要な場合は、まずそのファイルを以前に翻訳した人がい
るかどうかをgit logを用いて確認します。以前に翻訳した人がいれば、新しく
Issueを作って、その人を assignしてください。

## 翻訳ミスを見つけたら

翻訳ミスおよび、このREADMEに間違いやわからないところを見つけたら、遠慮
なく
[Issueとして登録](https://github.com/gentoojp/gentoo-doc-ja/issues/new)
してください。簡潔に書いてくださればそれで構いません。

## 困ったことがあったら

ツールの使い方や翻訳の言葉の選び方などわからないことがあれば、GentooJP
の翻訳チームに連絡してみてください。連絡先もいろいろありますが、お好み
でどれでも使ってください。

- Gitter: WebベースのGitHub連係機能を持ったチャット
    - https://gitter.im/gentoojp/gentoo-doc-ja
- GitHub Issues
    - https://github.com/gentoojp/gentoo-doc-ja/issues/
- Twitter
    - @naota344
- メーリングリスト
    - gentoojp-docs@ml.gentoo.gr.jp
