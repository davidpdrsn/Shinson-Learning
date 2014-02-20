require 'spec_helper'

feature 'viewing the homepage' do
  scenario 'a guest arrives at the home page' do
    visit root_path

    expect(page).to have_content "Sign in"
  end

  scenario 'a user signs in' do
    visit root_path

    fill_in "Email", with: 'bob@example.com'
    fill_in "Password", with: 'passwordlol'
    fill_in "Password confirmation", with: 'passwordlol'
    click_button "Sign up"

    expect(page).to have_content "Welcome"
  end
end
