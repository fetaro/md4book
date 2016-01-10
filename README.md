# md4book: Markdown parser for Book writting

md4bookはmarkdownで本を執筆するためのmarkdownパーサーです。

通常のmarkdownパーサの機能に加えて、相互参照、図表番号、章番号付与、目次作成、ノート、コラムなどに対応しています。

## 記法


```
■■見出し

# 章扉リード文

## 第1レベル見出し

### 第2レベル見出し

#### 第3レベル見出し

##### 第4レベル見出し

■■相互参照用見出し

# 章扉リード文
{: id="識別子"}

例)

# Markdownとは
{: id="capter_about-markdown"}

■■斜体

_斜体_

■■強調

__強調__

■■インラインコード・等幅フォント

`等幅フォント`

■■順序付きリスト

1. 操作手順1
1. 操作手順2
1. 操作手順3

■■箇条書き

* 箇条書き項目
* 箇条書き項目

■■図

![説明文](画像ファイル名){: id="識別子"}

例)

![Markdownの歴史](img_markdown_history.png){: id="img_markdown_history"}


出力)

 -----------
 |         |
 |   図    |
 |         |
 -----------
 図1.1:Markdownの歴史


■■表

{: title="表の名前" id="識別子" }
markdownの表

※titleは必須。idは参照しなければ省略可能

例)

{: title="金額一覧表" id="table_plice" }
|Right     | Left   | Center|
|---------:| :----- |:-----:|
|Computer  |  $1600 | one   |
|Phone     |    $12 | three |
|Pipe      |     $1 | eleven|



■■コード/リスト(渡部独自)

{: title="タイトル" id="識別子"}
~~~
コード本文
~~~

※titleは必須。idは参照しなければ省略可能

例)

{: title="プログラムのサンプル" id="sample.java"}
~~~
import xxx
public static void main(String argv[]){
    System.out.println("hello world");
}
~~~


■■コラム(渡部独自)

{: title="タイトル" id="識別子"}
<div class="column">
本文
</div>

※titleは必須。idは参照しなければ省略可能

例)

{: title="Markdownとは" id="column_about_markdown"}
<div class="column">
Markdownとは・・・
</div>


■■ノート(渡部独自)

{: title="タイトル" id="識別子"}
<div class="note">
本文
</div>

※titleは必須。idは参照しなければ省略可能

例)

{: title="Markdownは便利！" id="note_markdown_is_useful"}
<div class="note">
Markdownは便利！
</div>

■■フットノート

文字列[^hoge]文字列[^bar]

[^hoge]: 説明文
[^bar]: 説明文

例)

Markdown[^markdown]とHTML[^html]

[^markdown]: Markdownとは・・・
[^html]: HTMLとは・・・

■■相互参照(渡部独自)

[[識別子]]

例)

[[markdown.png]]を見てください。

出力)

図1-1を見てください。

```


# 現在開発中です
