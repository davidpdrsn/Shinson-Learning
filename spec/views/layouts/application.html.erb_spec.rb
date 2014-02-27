require 'spec_helper'

describe "layouts/application" do
  let(:user) { build_stubbed :user }
  before do
    controller.stub(:current_user).and_return(user)
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

    it "shows a link to create a new technique" do
      with_rendered_page do |page|
        expect(page).to have_link "New technique"
      end
    end

    it "shows a link to see your techniques" do
      with_rendered_page do |page|
        expect(page).to have_content "Techniques"
      end
    end

    it "shows a link a to the users profile" do
      with_rendered_page do |page|
        expect(page).to have_content "Profile"
      end
    end
  end

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

    it "shows a link to create a new technique" do
      with_rendered_page do |page|
        expect(page).not_to have_link "New technique"
      end
    end

    it "shows doesn't show a link to see your techniques" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Techniques"
      end
    end

    it "should not have a link to the users profile" do
      with_rendered_page do |page|
        expect(page).not_to have_content "Profile"
      end
    end
  end

  describe "showing the flashes" do
    before do
      controller.stub(:user_signed_in?).and_return(true)
    end

    context "when there is a flash notice" do
      before do
        controller.stub(:notice).and_return("foo")
        controller.stub(:alert).and_return("")
      end

      it "shows the flash notice" do
        with_rendered_page do |page|
          expect(page).to have_css ".flash.flash--notice", text: "foo"
        end
      end

      it "doesn't showt the flash alert element" do
        with_rendered_page do |page|
          expect(page).not_to have_css ".flash.flash--alert"
        end
      end
    end

    context "when there is a flash alert" do
      before do
        controller.stub(:alert).and_return("foo")
        controller.stub(:notice).and_return("")
      end

      it "shows the flash alert" do
        with_rendered_page do |page|
          expect(page).to have_css ".flash.flash--alert", text: "foo"
        end
      end

      it "doesn't showt the flash notice element" do
        with_rendered_page do |page|
          expect(page).not_to have_css ".flash.flash--notice"
        end
      end
    end
  end
end
