class AddsS
  def self.on(name)
    if name.match /s$/
      "#{name}'"
    else
      "#{name}'s"
    end
  end
end
