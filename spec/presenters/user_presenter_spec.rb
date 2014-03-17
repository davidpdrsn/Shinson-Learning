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
    it "returns email when provided with only email" do
      user = create :user, first_name: "", last_name: ""
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to match /#{user.email}/i
    end

    it "returns the first name when provided with first name" do
      user = create :user, last_name: ""
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to match /#{user.first_name}/i
    end

    it "returns the last name when provided with last name" do
      user = create :user, first_name: nil
      user_presenter = UserPresenter.new user, view

      expect(user_presenter.screen_name).to match /#{user.last_name}/i
    end

    it "returns the full when provided with first and last name" do
      user = create :user
      user_presenter = UserPresenter.new user, view
      name = [user.first_name, user.last_name].join(" ")

      expect(user_presenter.screen_name).to match /#{name}/i
    end
  end

  describe "#name_with_s" do
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

  describe "#techniques_count" do
    it "returns the number of techniques the user has", caching: true do
      user = create :user
      view = double :view
      user_presenter = UserPresenter.new user, view

      2.times { create :technique, user: user }
      expect(user_presenter.techniques_count).to eq 2

      2.times { create :technique, user: user }
      expect(user_presenter.techniques_count).to eq 4
    end
  end

  describe "#notes_count" do
    it "returns the number of notes the user has", caching: true do
      user = create :user
      user_presenter = UserPresenter.new user, double

      2.times { create :note, user: user }
      expect(user_presenter.notes_count).to eq 2

      2.times { create :note, user: user }
      expect(user_presenter.notes_count).to eq 4
    end
  end

  describe "#edit link" do
    it "returns a edit link for the user" do
      user = create :user
      user_presenter = UserPresenter.new user, view
      view.stub :link_to

      user_presenter.edit_link

      expect(view).to have_received(:link_to).with "Edit information",
                                                   edit_user_registration_path,
                                                   { class: "button button--small" }
    end
  end

  describe "#destroy_link" do
    it "returns a destroy link for the user" do
      user = create :user
      user_presenter = UserPresenter.new user, view
      view.stub :link_to

      user_presenter.destroy_link

      expect(view).to have_received(:link_to).with "Delete account",
                                                   view.registration_path(user),
                                                   {
                                                     data: { confirm: "Are you sure?" },
                                                     method: :delete,
                                                     class: "button button--small button--red"
                                                   }
    end
  end
end
