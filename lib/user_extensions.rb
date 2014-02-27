require_relative 'adds_s'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module UserExtensions
  def s
    AddsS.on screen_name
  end

  def screen_name
    return email unless first_name or last_name

    [first_name, last_name].reject(&:blank?).map(&:to_s).map(&:titleize).join(" ")
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
