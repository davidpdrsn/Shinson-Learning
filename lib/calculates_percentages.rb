class CalculatesPercentages
  def self.of a, b
    return 0 if b == 0

    (a.to_f / b) * 100
  end
end
