class MarkdownParser
  def initialize
    @parser = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:hard_wrap => true)
    )
  end

  def parse(markdown)
    parser.render(markdown)
  end

  private

  attr_reader :parser
end
