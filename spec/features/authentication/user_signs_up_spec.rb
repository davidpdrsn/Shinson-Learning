require 'spec_helper'

feature "user signs up" do
  scenario 'the sign up is successful' do
    sign_up

    expect(page).to have_content "Welcome"
  end

  scenario "user doesn't fill in required information" do
    sign_up build(:user, email: "")

    expect(page).to have_content "can't be blank"
  end
end
