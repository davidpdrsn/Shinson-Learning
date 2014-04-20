class Cacher
  def initialize obj, cache
    instance_variable_set :"@#{obj.class.to_s.downcase}", obj
    @cache = cache
  end
end
