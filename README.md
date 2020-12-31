# mdengine

MarkDown形式のファイルをHTMLに変換&簡単なサイトを作成するためのRubyプログラム群です  

## How To Use
### 必要なもの
- Ruby 2.7+ (x86_64)

`ruby ./main.rb help`でヘルプを表示します

```
ruby main.rb [argment] [filename]

--build [filename] --生HTMLを生成
--build-all [生成後のファイル名] --buildで生成された中間ファイルに
スタイルを適用して./public以下に生成
-v バージョン表示
```

CSSのファイルは`./publish/common.css`です  
HTMLのテンプレートは`makehtml.rb`に直接書き込まれています  
サイト名などは空白になっているので適宜書き換えてください.
