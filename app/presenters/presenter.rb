class Presenter
  def initialize object, template
    @object = object
    @template = template
  end

  def timestamp method = :created_at
    Rails.cache.fetch([@object, :timestamp, method]) do
      date = @object.send method
      "#{date.to_formatted_s(:short)} (#{h.time_ago_in_words date} ago)"
    end
  end

  private

  def self.presents name
    define_method name do
      @object
    end
  end

  def h
    @template
  end
end
