require_relative '../../lib/technique_extensions'

class DummyTechnique
  include TechniqueExtensions::Delegators
  include TechniqueExtensions::Comparisons
end

describe TechniqueExtensions::Delegators do
  let(:technique) { DummyTechnique.new }
  let(:fake_thing) { double(:fake_thing).as_null_object }
  before do
    fake_thing.stub(:pretty_print)

    [
      :category,
      :belt
    ].each do |m|
      technique.stub(m) { fake_thing }
    end
  end

  describe "#category_html_class" do
    it "delegates to category" do
      technique.category_name

      expect(fake_thing).to have_received :name
    end
  end

  describe "#belt_pretty_print" do
    it "delegates to belt" do
      technique.belt_pretty_print

      expect(fake_thing).to have_received :pretty_print
    end
  end
end

describe TechniqueExtensions::Comparisons do
  it "compares the names and the numbers in the name" do
    a = DummyTechnique.new
    b = DummyTechnique.new
    c = DummyTechnique.new
    a.stub(:name) { "Gibon sul 2" }
    b.stub(:name) { "Gibon sul 10" }
    c.stub(:name) { "Gibon sul" }

    expect(a).to be < b
    expect(c).to be < a
  end
end
