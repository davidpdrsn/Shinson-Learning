require 'active_support/core_ext/string/inflections'

module BeltExtensions
  module PrettyPrinter
    def pretty_print
      "#{color.titleize} (#{degree.downcase})"
    end
  end
end
