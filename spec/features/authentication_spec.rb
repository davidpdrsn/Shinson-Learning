require 'spec_helper'

feature 'authentication' do
  let(:user) { build :user, first_name: "Bob", last_name: "Anderson" }

  scenario 'a guest arrives at the home page' do
    visit root_path

    expect(page).to have_content "Sign in"
  end

  scenario 'a user signs up' do
    sign_up

    expect(page).to have_content "Welcome"
  end

  scenario 'a user signs up and gives their name' do
    sign_up user

    expect(page).to have_content "Welcome"
    expect(page).to have_content "Bob Anderson"
  end

  scenario 'a user signs in' do
    sign_up user
    logout
    sign_in user

    expect(page).to have_content "Log out"
  end
end
