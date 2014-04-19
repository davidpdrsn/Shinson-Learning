class Zipper
  def initialize vals
    @vals = vals
  end

  def zip
    0.upto(number_of_attrs - 1).inject([]) do |acc, n|
      acc << attrs_at_position(n)
    end
  end

  private

  def attrs_at_position n
    @vals.inject({}) do |acc, (key, val)|
      acc[key] = val[n]
      acc
    end
  end

  def number_of_attrs
    @vals[@vals.keys.first].length
  end
end
