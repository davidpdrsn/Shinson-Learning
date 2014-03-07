require 'spec_helper'

describe UserPresenter do
  describe "#name" do
    it "returns the name" do
      user = double :user, first_name: "Bob", last_name: "Johnson"
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.name).to eq "Bob Johnson"
    end

    it "says when none given" do
      user = double :user, first_name: nil, last_name: nil
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.name).to eq "None given"
    end
  end
end
