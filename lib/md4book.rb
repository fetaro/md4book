# -*- coding: utf-8 -*-
require "md4book/version"
require "kramdown"

$cap_no = [0,0,0,0,0,0]
$cap_kanji = ["","章","節","項","",""]
$img_count = 0
$id_map = {}
module Kramdown
  module Converter
    class Html < Base

      # @override
      def convert_header(el, indent)
        attr = el.attr.dup
        if @options[:auto_ids] && !attr['id']
          #attr['id'] = generate_id(el.options[:raw_text])
        end
        @toc << [el.options[:level], attr['id'], el.children] if attr['id'] && in_toc?(el)
        level = output_header_level(el.options[:level])
        $cap_no[level] += 1
        for i in level+1..$cap_no.size
          $cap_no[i] = 0
        end
        cap_no_str = $cap_no.reject{|c|c == 0}.map{|c| c == 0 ? "" : c.to_s}.join("-")
        cap_header = cap_no_str + $cap_kanji[level] 
        cited =  cap_header + "「" + inner(el, indent) + "」" #相互参照の文字列
        text =  cap_header + "." + inner(el, indent) #章の文字列
        if attr['id']
          $id_map[attr['id']] = {
            :id => attr['id'], 
            :cap_header => cap_header,
            :cited => cited,
            :level => el.options[:level],
            :text => text,
            :raw_text => el.options[:raw_text],
            :location => el.options[:location]
          }
        end
        if level == 1
          $ing_count = 0
        end
        format_as_block_html("h#{level}", attr, text, indent)
      end

      # @override
      def convert_img(el, indent)
        $img_count += 1
        cited = "図#{$cap_no[1]}-#{$img_count}.#{el.attr['alt']}"
        if el.attr['id']
          $id_map[el.attr['id']] = {
            :id => el.attr['id'], 
            :src => el.attr['src'], 
            :alt => el.attr['alt'], 
            :cited => cited,
            :location => el.options[:location]
          }
        end
        img_tag = "<img#{html_attributes(el.attr)} />"
        caption = cited
        return "<center>" + img_tag + "<br/>\n" + caption + "</center>" 
      end

      # Return the converted content of the children of +el+ as a string. The parameter +indent+ has
      # to be the amount of indentation used for the element +el+.
      #
      # Pushes +el+ onto the @stack before converting the child elements and pops it from the stack
      # afterwards.
      def inner(el, indent)
        result = ''
        indent += @indent
        @stack.push(el)
        el.children.each do |inner_el|
          result << send(DISPATCHER[inner_el.type], inner_el, indent)
        end
        @stack.pop
        result
      end

    end
  end
end

module Md4book
  module_function
  def to_html(md)
    body = Kramdown::Document.new(md).to_html

    $id_map.each_key do |key|
      body.gsub!("\[\[#{key}\]\]","<a href=\"\##{key}\">#{$id_map[key][:cited]}</a>")
    end

    # debug
    require 'pp'
    pp $id_map

    html = <<EOL
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="main.css" media="all">
</head>
<body>
#{body}
</body>
</html>
EOL

    return html
  end
end
