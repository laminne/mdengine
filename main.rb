## MarkDown-HTML Generator
# 2020 Tatsuto "Laminne" Yamamoto
# This code licensed under MIT License.

require './makehtml'

if ARGV.count > 3
  puts("[err] 引数の数が多すぎます")
  exit(1)
end

if ARGV[0] == "--build" && ARGV[1] != nil
  p "[info] ビルドを開始します"
  $filename = ARGV[1]
  Make.build
  p "[log] ./md.html を中間ファイルとして生成しました\n このファイルは変更しないでください"
end

if ARGV[0] == "--build-all" && ARGV[1] != nil
  $filename = ARGV[1]
  p "[info] 中間ファイルからページを生成します\nビルド終了後に./publish/#{$filename}.html が生成されます"
  Make.publish
  p "[info] ビルドが終了しました"
end

if ARGV[0] == "--help" || ARGV[0] == "-h"
  p "-----MarkDown-HTML Generator-----"
  p "ruby main.rb [argments] [filename]"
  p "--build [MDのファイル名]  スタイル適用前の生HTMLを生成"
  p "--build-all [生成後のファイル名]  スタイルを適用したページを生成"
  p "-v バージョンを表示"
end

if ARGV[0] == "-v"
  p "MD-HTML Generator Ver. 1.0.2"
  p "2020/12/31"
end