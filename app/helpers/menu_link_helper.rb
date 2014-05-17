module MenuLinkHelper
  def nav_link_to name, path, options = {}
    if request.fullpath.split("?").first == path
      options[:class] ||= ""
      options[:class] += " current"
    end

    link_to name, path, options
  end
end
