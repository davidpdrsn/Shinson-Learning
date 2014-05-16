require 'spec_helper'

feature 'deleting account' do
  let(:user) { build :user }
  before { sign_up user }

  scenario 'user sees that his account is gone and has to sign up again' do
    click_link "Profile"
    click_link "Delete account"

    expect(page).to have_content "Log in"
  end
end
