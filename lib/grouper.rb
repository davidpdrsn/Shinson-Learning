class Grouper
  def initialize(things)
    @things = things
  end

  def group_by(*methods)
    first_method = methods.first
    rest_of_methods = methods[(1..methods.length)]

    if rest_of_methods.empty?
      do_grouping(first_method)
    else
      self.class.new(do_grouping(first_method)).group_by(*rest_of_methods)
    end
  end

  private

  def do_grouping(method)
    if @things.is_a?(Hash)
      @things.each do |k, vs|
        @things[k] = self.class.new(vs).group_by(method)
      end
    else
      @things.group_by do |t|
        t.send(method)
      end
    end
  end
end
