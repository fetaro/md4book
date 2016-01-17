#!/usr/bin/ruby
require 'md4book'
require 'pp'

# parse argument 
if ARGV[0].nil? 
  STDERR.puts "USAGE: ruby #{$0} target.md"
  exit 1
end
target = ARGV[0]

puts Md4book.to_html(File.read(target))

