require "md4book"

md = <<-MD
# A
{: id="capter_first"}

## B

## C

### D

### E

## F

## H


MD

md2 = <<-MD2
# first
{: id="capter_first"}

# second
{: id="capter_second"}

[[capter_first]]

[[capter_second]]
MD2

puts Md4book.to_html(md2)
