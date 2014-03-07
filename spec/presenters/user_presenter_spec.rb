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

  describe "#screen_name" do
    let(:email) { "bob@example.com" }
    let(:first_name) { "Bob" }
    let(:last_name) { "Johnson" }

    it "returns email when provided with only email" do
      user = double :user,
                    first_name: nil,
                    last_name: nil,
                    email: email
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to eq email
    end

    it "returns the first name when provided with first name" do
      user = double :user,
                    first_name: first_name,
                    last_name: nil,
                    email: nil
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to eq first_name
    end

    it "returns the last name when provided with last name" do
      user = double :user,
                    first_name: nil,
                    last_name: last_name,
                    email: nil
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to eq last_name
    end

    it "returns the full when provided with first and last name" do
      user = double :user,
                    first_name: first_name,
                    last_name: last_name,
                    email: nil
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to eq [first_name, last_name].join(" ")
    end
  end

  describe "#s" do
    it "adds 's" do
      user = double :user, first_name: "Bob", last_name: "Johnson"
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.name_with_s).to eq "Bob Johnson's"
    end

    it "doesnt add the ' when it shouldn't" do
      user = double :user, first_name: "Bob", last_name: "Johnsons"
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.name_with_s).to eq "Bob Johnsons'"
    end
  end

  describe "#link_to_user" do
    it "returns a link to that user" do
      user = double :user, first_name: "Bob", last_name: "Johnson"
      view = double(:view).as_null_object
      user_presenter = UserPresenter.new user, view

      user_presenter.link_to_user

      expect(view).to have_received(:link_to).with(user_presenter.screen_name, user_presenter.user)
    end
  end

  describe "#mailto_link" do
    it "returns a mailto link" do
      user = double :user, email: "bob@example.com"
      view = double(:view).as_null_object
      user_presenter = UserPresenter.new user, view

      user_presenter.mailto_link

      expect(view).to have_received(:mail_to).with(user_presenter.email, user_presenter.email)
    end
  end
end
