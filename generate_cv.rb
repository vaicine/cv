#!/usr/bin/env ruby

require "rubygems"
require "redcarpet"
require "pdfkit"

class CvRenderer < Redcarpet::Render::HTML
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


class HtmlCv
  def self.generate!(input:, output:)
    print "Generating HTML..."

    markdown = File.open(input)
    html = markdown(markdown.read)

    File.write(output, html)

    puts "Done!"
  end

  def self.markdown(text)
    markdown = Redcarpet::Markdown.new(CvRenderer.new(),
      :tables              => true,
      :autolink            => true
    )

    markdown.render(text);
  end
end

class PdfCv
  def self.generate!(input:, output:)
    print "Generating PDF..."

    pdf = PDFKit.new(File.new(input))
    file = pdf.to_file(output)

    puts "Done!"
  end
end

HtmlCv.generate!(input: "README.md", output: "index.html")
PdfCv.generate!(input: "index.html", output: "james-harries-cv.pdf")
