require 'spec_helper'

describe Presenter do
  describe "#timestamp" do
    it "returns a human readable time stamp" do
      user = double(:user).as_null_object
      view = double(:view).as_null_object
      presenter = Presenter.new user, view
      fake_date = double(:date).as_null_object

      user.stub(:created_at) { fake_date }

      presenter.timestamp :created_at

      expect(user).to have_received(:created_at)
      expect(fake_date).to have_received(:to_formatted_s).with(:short)
      expect(view).to have_received(:time_ago_in_words).with(fake_date)
    end
  end
end
