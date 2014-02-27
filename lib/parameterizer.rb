module Parameterizer
  def to_param
    [id, name.parameterize].join("-")
  end
end
