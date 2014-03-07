require_relative 'adds_s'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module UserExtensions
  def s
    AddsS.on screen_name
  end

  module Queries
    def questions
      notes.where(question: true).includes(:technique)
    end

    def sorted_techniques
      techniques.includes(:category, :belt).sort
    end
  end
end
