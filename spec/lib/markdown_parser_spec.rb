require 'spec_helper'

describe MarkdownParser do
  it 'parses markdown' do
    parser = MarkdownParser.new
    expect(parser.parse("**hi**")).to match("<strong>hi</strong>")
  end

  it 'parses some more markdown' do
    parser = MarkdownParser.new
    expect(parser.parse("[link](/)")).to match('<a href="/">link</a>')
  end
end
