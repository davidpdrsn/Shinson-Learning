require 'spec_helper'
require 'adds_white_techniques'
require_relative '../../db/seeds'

describe AddsWhiteTechniques do
  let(:bob) { create :user }
  let(:su) { Category.find_by name: "Su" }
  let(:kicks) { Category.find_by name: "Jokgi Sul" }
  let(:white) { Belt.find_by color: "White" }

  before do
    create_categories
    create_belts
  end

  it "adds white belt techniques to a user" do
    AddsWhiteTechniques.new(bob).add_techniques

    expect(bob.techniques.where(category: su, belt: white).count).to eq 6
    expect(bob.techniques.where(category: kicks, belt: white).count).to eq 5
  end

  it "doesn't add the techniques to a user who already has them" do
    AddsWhiteTechniques.new(bob).add_techniques
    AddsWhiteTechniques.new(bob).add_techniques

    expect(bob.techniques.where(category: su, belt: white).count).to eq 6
    expect(bob.techniques.where(category: kicks, belt: white).count).to eq 5
  end
end
