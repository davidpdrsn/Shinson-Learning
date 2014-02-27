require_relative '../../lib/grouper_techniques'

class DummyTechnique
  extend Grouper::Techniques
end

describe Grouper::Techniques do
  describe "#for_user_grouped_by" do
    it "delegates to grouper" do
      techniques = [double, double]
      user = double sorted_techniques: techniques
      fake_grouper = double.as_null_object
      Grouper.stub(:new) { fake_grouper }
      DummyTechnique.for_user_grouped_by(user, :one, :two)

      expect(Grouper).to have_received(:new).with(techniques)
      expect(fake_grouper).to have_received(:group_by).with(:one, :two)
    end
  end
end
