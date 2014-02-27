require 'spec_helper'

feature 'user crud' do
  scenario 'a user views his profile' do
    user = build :user
    sign_up user
    click_link "Profile"

    expect(page).to have_content user.screen_name
  end
end
