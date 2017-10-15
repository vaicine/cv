#!/usr/bin/env ruby

require 'rubygems'
require 'redcarpet'

class CVRenderer < Redcarpet::Render::HTML

  def doc_header
    <<-HTML.gsub /^\s+/, ""
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>James Lewis Harries CV</title>
    <link rel="stylesheet" href="style.css">
    </head>
    <body>
    HTML
  end

  def doc_footer
    <<-HTML.gsub /^\s+/, ""
    </body>
    </html>
    HTML
  end
end

def markdown(text)
  markdown = Redcarpet::Markdown.new(CVRenderer.new(),
    :tables              => true,
    :autolink            => true
  )
  markdown.render(text);
end

markdown = File.open("README.md")
html = markdown(markdown.read)

File.write("index.html", html)

puts "Done!"
