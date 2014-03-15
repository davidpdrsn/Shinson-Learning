require 'spec_helper'

feature 'user signs in' do
  let(:user) { build :user, first_name: "Bob", last_name: "Anderson" }

  scenario 'user sees button to logout' do
    sign_up user
    logout
    sign_in user

    expect(page).to have_content "Log out"
  end
end
