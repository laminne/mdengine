## MarkDown-HTML Generator
# 2020 Tatsuto "Laminne" Yamamoto
# This code licensed under MIT License.

class Make
  class << self
    def build
      begin
        File.foreach("#{$filename}.md") do |md|

          if md.start_with?("#")
            if md.count("/^#/") == 1
              md = md.sub(/^#/ , "<h1>")
              md = md.sub("\n", "")
              md = "#{md}</h1>"
            end
            if md.count("/^#/") == 2
              md = md.sub(/^##/ , "<h2>")
              md = md.sub("\n", "")
              md = "#{md}</h2>"
            end
            if md.count("/^#/") == 3
              md = md.sub(/^###/ , "<h3>")
              md = md.sub("\n", "")
              md = "#{md}</h3>"
            end
            if md.count("/^#/") == 4
              md = md.sub(/^####/, "<h4>")
              md = md.sub("\n", "")
              md = "#{md}</h4>"
            end
            if md.count("/^#/") == 5
              md = md.sub(/^#####/, "<h5>")
              md = md.sub("\n", "")
              md = "#{md}</h5>"
            end
            if md.count("/^#/") == 6
              md = md.sub(/^######/, "<h6>")
              md = md.sub("\n", "")
              md = "#{md}</h6>"
            end
          end

          if md.start_with?("!image(")
            md = md.sub("!image(", '<img src="')
            md = md.sub(")", "")
            md = "#{md}\"><br>"
          end

          if md.start_with?("#") == false && md.start_with?("!image(") == false && md.start_with?("<") == false
            md = "<p>#{md}</p>"
          end
          html = "md.html"
          File.open(html, "w").puts("")
          File.open(html, "a").puts(md)

        end
      end
    end

    def publish
      @body = File.read("md.html")
      File.open("./publish/#{$filename}.html", "w") do |f|
        f.puts("<!DOCTYPE html>
<html lang='ja'>
<head>
    <meta charset='UTF-8'>
    <title></title>
    <link rel='stylesheet' href='common.css'>
</head>
<body>
<header>
    <h2 class='site-title'><a href='/'>laminne</a></h2>
    <hr>
</header>

#{@body}

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