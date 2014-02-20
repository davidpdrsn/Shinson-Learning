require 'spec_helper'

feature 'viewing the homepage' do
  scenario 'a guest arrives at the home page' do
    visit root_path

    expect(page).to have_content "Sign in"
  end
end
