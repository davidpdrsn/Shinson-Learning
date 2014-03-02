require 'spec_helper'
require_relative 'perf_helpers'

describe TechniquesController, type: :controller do
  it "is quite fast" do
    user = create :user
    sign_in user
    categories = (1..10).map { create :category }
    belts = (1..10).map { create :belt }
    100.times do
      create :technique,
             user: user,
             category: categories.sample,
             belt: belts.sample
    end

    benchmark do
      get :index
    end
  end
end
