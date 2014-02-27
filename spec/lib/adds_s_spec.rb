require_relative '../../lib/adds_s'

describe AddsS do
  describe "#s" do
    it "adds 's to the users screen name" do
      expect(AddsS.on("Bob Johnson")).to eq "Bob Johnson's"
    end

    it "adds ' when the users name ends in s" do
      expect(AddsS.on("Bob Johnsons")).to eq "Bob Johnsons'"
    end
  end
end
