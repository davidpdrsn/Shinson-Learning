require_relative '../../lib/parameterizer'

class Thing
  include Parameterizer
end

describe Parameterizer do
  it "converts an array to a string for a url" do
    name = "Gibon sul #1"
    name.stub(:parameterize) { "gibon-sul-1" }
    thing = Thing.new
    thing.stub(:id) { 1 }
    thing.stub(:name) { name }
    result = thing.to_param

    expect(result).to eq "1-gibon-sul-1"
  end
end
