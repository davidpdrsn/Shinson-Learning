require 'spec_helper'

describe "users/show" do
  let(:user) { build_stubbed :user }

  before do
    view.stub(:timestamp)
    assign(:user, user)
  end

  context "when viewing your own profile" do
    before do
      controller.stub(:current_user).and_return(user)
    end

    it "shows link to update" do
      with_rendered_page do |page|
        expect(page).to have_content "Edit information"
      end
    end

    it "shows link to destroy" do
      with_rendered_page do |page|
        expect(page).to have_content "Delete account"
      end
    end
  end

  context "when viewing someone elses profile" do
    let(:another_user) { build_stubbed :user }

    before do
      controller.stub(:current_user).and_return(another_user)
    end

    it "doesn't show edit link" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Edit information"
      end
    end

    it "doesn't show delete link" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Delete account"
      end
    end
  end
end
