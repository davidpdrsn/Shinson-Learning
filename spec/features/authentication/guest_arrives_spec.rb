require 'spec_helper'

feature "guest arrives at the homepage" do
  scenario "he is asked to login" do
    visit root_path

    expect(page).to have_content "Sign in"
  end
end
