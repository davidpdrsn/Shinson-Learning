require 'spec_helper'
require_relative 'perf_helpers'

describe TechniquesController, type: :controller do
  it "is quite fast" do
    user = create :user
    sign_in user
    technique = create :technique, user: user
    attr = build(:technique, user: user).attributes

    benchmark do
      post :create, technique: attr
    end
  end
end
