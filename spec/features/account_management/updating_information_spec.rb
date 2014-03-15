require 'spec_helper'

feature 'updating account information' do
  let(:user) { build :user }
  before { sign_up user }

  scenario 'a user updates his information' do
    click_link "Profile"
    click_link "Edit information"
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Pedersen"
    fill_in "Current password", with: user.password
    click_button "Update"

    expect(page).to have_content "Foo Pedersen"
  end
end
