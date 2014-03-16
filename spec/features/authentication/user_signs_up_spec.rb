require 'spec_helper'
require_relative '../../../db/seeds'

feature "user signs up" do
  scenario 'the sign up is successful' do
    sign_up

    expect(page).to have_content "Welcome"
  end

  scenario "user doesn't fill in required information" do
    sign_up build(:user, email: "")

    expect(page).to have_content "can't be blank"
  end

  scenario "user chooses to have the white belt techniques added automatically" do
    user = build :user
    create_categories
    create_belts

    visit root_path

    click_link "Sign up"
    fill_in "Email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    check "Add white belt techniques"
    click_button "Sign up"
    visit techniques_path

    expect(page).not_to have_content "You have no techniques yet"
  end
end
