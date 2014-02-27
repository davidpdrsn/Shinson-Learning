require_relative '../../lib/belt_extensions'

class DummyBelt
  include BeltExtensions::PrettyPrinter
end

describe "#pretty_print" do
  describe "#pretty_print" do
    it "pretty prints the belt" do
      belt = DummyBelt.new
      belt.stub(color: "white")
      belt.stub(degree: "Mu kup")

      expect(belt.pretty_print).to eq "White (mu kup)"
    end
  end
end
