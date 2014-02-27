require 'spec_helper'

feature 'user crud' do
  let(:user) { build :user }

  before { sign_up user }

  scenario 'a user views his profile' do
    click_link "Profile"

    expect(page).to have_content user.screen_name
  end

  scenario 'a user updates his information' do
    click_link "Profile"
    click_link "Edit information"
    fill_in "First name", with: "David"
    fill_in "Last name", with: "Pedersen"
    click_button "Update"

    expect(page).to have_content "David Pedersen"
  end

  scenario 'a user deletes his account' do
    click_link "Profile"
    click_link "Delete account"

    expect(page).to have_content "Sign in"
    expect(page).to have_content "Account deleted"
  end
end
