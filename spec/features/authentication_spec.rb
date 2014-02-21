require 'spec_helper'

feature 'authentication' do
  scenario 'a guest arrives at the home page' do
    visit root_path

    expect(page).to have_content "Sign in"
  end

  scenario 'a user signs up' do
    sign_up

    expect(page).to have_content "Welcome"
  end

  scenario 'a user signs in' do
    sign_up
    logout
    sign_in

    expect(page).to have_content "Log out"
  end
end
