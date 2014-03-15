require 'spec_helper'

feature 'user signs up with name spec' do
  let(:user) { build :user, first_name: "Bob", last_name: "Anderson" }

  scenario 'user sees his name and a welcome message' do
    sign_up user

    expect(page).to have_content "Welcome"
    expect(page).to have_content "Bob Anderson"
  end
end
