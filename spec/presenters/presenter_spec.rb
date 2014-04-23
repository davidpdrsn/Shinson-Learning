require 'spec_helper'

describe Presenter do
  describe "#timestamp" do
    it "returns a human readable time stamp" do
      user = create :user
      presenter = Presenter.new user, view

      Timecop.freeze(Date.new 1990, 8, 6) do
        user.touch

        expect(presenter.timestamp :updated_at).to eq "06 Aug 00:00 (less than a minute ago)"
      end
    end
  end
end
