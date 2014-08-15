class TestCache
  attr_reader :writes, :reads

  def initialize
    @reads = 0
    @writes = 0
  end

  def fetch objs, &block
    wrote = false

    stored_return_value = Rails.cache.fetch(objs) do
      wrote = true
      @writes += 1
      block.call
    end

    @reads += 1 unless wrote

    stored_return_value
  end
end

def test_cache_behavior(cache, &block)
  expect(cache.reads).to eq 0
  expect(cache.writes).to eq 0

  block.call
  expect(cache.writes).to eq 1
  expect(cache.reads).to eq 0

  block.call
  expect(cache.writes).to eq 1
  expect(cache.reads).to eq 1
end
