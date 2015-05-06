class SearchResult
  def initialize(query, techniques)
    @query = query
    @techniques = techniques
  end

  attr_reader :query, :techniques

  def count
    @techniques.count
  end
end
