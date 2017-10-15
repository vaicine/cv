#!/usr/bin/env ruby

require "rubygems"
require "pdfkit"

kit = PDFKit.new(File.new('index.html'))
file = kit.to_file('cv.pdf')

puts "Done!"
