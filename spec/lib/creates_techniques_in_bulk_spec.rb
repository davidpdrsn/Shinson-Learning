require 'spec_helper'

describe CreatesTechniquesInBulk do
  it "creates a bunch of techniques" do
    bob, category, belt, technique_attributes = record_setup

    techniques = CreatesTechniquesInBulk.new(technique_attributes).create_for_user bob

    expect(techniques).to be_empty
    expect(bob.techniques.count).to eq 10
  end

  it "returns the invalid techniques" do
    bob, category, belt, technique_attributes = record_setup

    technique_attributes.first[:category_id] = nil

    techniques = CreatesTechniquesInBulk.new(technique_attributes).create_for_user bob

    expect(techniques.length).to eq 1
    expect(bob.techniques.count).to eq 9
  end

  def record_setup
    user = create :user
    category = create :category
    belt = create :belt
    technique_attributes = attributes_for_techniques category_id: category.id,
                                                     belt_id: belt.id,
                                                     count: 10

    return user, category, belt, technique_attributes
  end

  def attributes_for_techniques options
    count = options[:count] || 10

    1.upto(count).inject([]) do |acc|
      attributes = attributes_for :technique
      attributes[:category_id] = options.fetch :category_id
      attributes[:belt_id] = options.fetch :belt_id

      acc << attributes
    end
  end
end
