require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module UserExtensions
  module Queries
    def questions
      notes.where(question: true).includes(:technique)
    end

    def sorted_techniques
      techniques.includes(:category, :belt).sort
    end
  end
end
