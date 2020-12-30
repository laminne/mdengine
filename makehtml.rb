## MarkDown-HTML Generator
# 2020 Tatsuto "Laminne" Yamamoto
# This code licensed under MIT License.

class Make
  @html_indent = "  "

  class << self
    def build
      File.open("md.html", "w") do |file| # 書き込むファイル
        # i = 0    # show file
        code_block = ""
        is_li = false
        indent_size = 0
        before_indent = 0

        File.foreach("#{$filename}") do |line| # 読み込むファイル
          line.chomp!
          skip_p = false
          # i += 1    # show file
          # (3 - i.to_s.length).times { print " " }     # show file
          # puts "#{i} | #{line}"    # show file

          # コードブロックの中
          if code_block != ""
            if line == "```" # コードブロックの終わり
              file.puts "<pre>#{code_block}</pre>"
              code_block = ""
            else
              code_block += line + "\n"
            end
            next
          end
          
          # <code> インライン表示
          if line !~ /^```\w*$/ # && line =~ /`(.+)`/
            line.gsub!(/`(.+)`/, "<code>\\1</code>")
          end
          # <img> 画像
          if line =~ /\!\[(.*)\]\((.*)\)/
            line = "<img src=\"#{$2}\" alt=\"#{$1}\" />"
            skip_p = true
          end
          # <a> リンク
          if line =~ /\[(.*)\]\((.*)\)/
            line = "<a href=\"#{$2}\">#{$1}</a>"
          end
          # <h1> ~ <h6> 見出し
          if line =~ /(#){1,6}\s+(.*)/
            count = line.count("#")
            line = "<h#{count}>#{$2}</h#{count}>"
            skip_p = true
          end

          # 行頭から始まる記法
          # <pre> コードブロック
          if line =~ /^```\w*$/
            line.sub!(/^```/, "")
            code_block += line + "\n"
            next
          # <blockquote>
          elsif line =~ /^\s*>/ # TODO 実装方法の見直し
            count = line.scan(/^\s*>+\s*/).first.count(">")
            content = line.sub(/>+\s*(.+)/, "\\1")
            line = ""
            count.times {line += "<blockquote>"}
            line += content
            count.times {line += "</blockquote>"}
          # <li>
          elsif line =~ /^\s*(\*|-)/
            indent_size = line.sub(/^(\s*)(\*|-).*$/, "\\1").count(" ")
            indent_size /= 4
            ul_space = @html_indent * indent_size
            li_space = @html_indent * (indent_size + 1)
            if !is_li || indent_size - before_indent == 1
              is_li = true
              li = line.gsub(/^\s*(\*|-)\s+(.+)/, "#{li_space}<li>\\2</li>")
              line = "#{ul_space}<ul>\n" + li
            elsif before_indent - indent_size == 1
              li = line.gsub(/^\s*(\*|-)\s+(.+)/, "#{li_space}<li>\\2</li>")
              line = "#{li_space}</ul>\n" + li
            elsif is_li
              line.gsub!(/^\s*(\*|-)\s+(.+)/, "#{li_space}<li>\\2</li>")
            else

            end
            before_indent = indent_size
          # elsif line.start_with?("!image(")
          #   line.sub!("!image(", '<img src="')
          #   line.sub!(")", "")
          #   line += "\"><br>"
          # elsif !line.start_with?("<")
          #   line = "<p>#{line}</p>"
          elsif line == "" # 空行
            if is_li
              (indent_size + 1).times do
                line += "#{@html_indent * indent_size}</ul>\n"
                indent_size -= 1
              end
              line += "\n"
              is_li = false
              before_indent = 0
              indent_size = 0
            end
          else
            line = "<p>#{line}</p>" unless skip_p
          end
            
          file.puts line
        end
      end
    end

    def publish
      _body = File.read("md.html")
      body = _body.split(/\R/).map {|line| line = '      ' + line + "\n" }.join
      File.open("./publish/#{$filename}.html", "w") do |f|
        f.puts("<!DOCTYPE html>
<html lang=\"ja\">
  <head>
    <meta charset=\"UTF-8\">
    <title>#{$filename}</title>
    <link rel=\"stylesheet\" href=\"common.css\">
  </head>
  <body>
    <header>
      <h2 class=\"site-title\"><a href=\"/\">laminne</a></h2>
      <hr>
    </header>

    <main>
#{body}
    </main>

    <footer>
      <hr>
      <p>&copy; laminne</p>
    </footer>
  </body>
</html>
")
      end
    end

  end
end
