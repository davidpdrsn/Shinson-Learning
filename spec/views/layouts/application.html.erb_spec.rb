require 'spec_helper'

describe "layouts/application" do
  context "when the user is not logged in" do
    before do
      controller.stub(:user_signed_in?).and_return(false)
    end

    it "shows the sign up link" do
      with_rendered_page do |page|
        expect(page).to have_content "Sign up"
      end
    end

    it "shows the link to sign in" do
      with_rendered_page do |page|
        expect(page).to have_content "Sign in"
      end
    end

    it "doesn't show the link to log out" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Log out"
      end
    end
  end

  context "when the user is logged in" do
    before do
      controller.stub(:user_signed_in?).and_return(true)
    end

    it "shows the logout link" do
      with_rendered_page do |page|
        expect(page).to have_content "Log out"
      end
    end

    it "doesn't show the sign up link" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Sign up"
      end
    end

    it "doesn't show the sign in link" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Sign in"
      end
    end
  end
end
