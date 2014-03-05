class MathHelper
  def self.percentage_difference a, b
    return 0 if b == 0

    (a.to_f / b) * 100
  end

  def self.average values
    values.inject(0, :+) / values.length
  rescue ZeroDivisionError
    0
  end
end
