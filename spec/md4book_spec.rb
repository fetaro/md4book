# -*- coding: utf-8 -*-
require 'spec_helper'

describe Md4book do
  it 'has a version number' do
    expect(Md4book::VERSION).not_to be nil
  end

  it 'does something useful' do
    md = <<-MD
# first
{: id="capter_first"}

## unko

# second
{: id="capter_second"}

[[capter_first]]

[[capter_second]]
MD
    html = <<-HTML
<h1 id="capter_test">test</h1>

<h1 id="capter_second">test</h1>

<p>1章. test</p>
HTML
    puts Md4book.to_html(md)
    expect(false).to eq(true)
  end
end
