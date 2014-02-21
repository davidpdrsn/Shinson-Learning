require 'spec_helper'

feature 'peaking at techniques' do
  scenario "a user peeks at a technique", js: true do
    sign_up
    create_technique("Ap chagi", "Front kick", "White (mu kup)")
    visit root_path
    click_link "My techniques"
    click_link "White (mu kup)"
    click_link "Peek"

    expect(page).to have_content "Front kick"
  end

  scenario "a user peeks and then unpeeks", js: true do
    sign_up
    create_technique("Ap chagi", "Front kick", "White (mu kup)")
    visit root_path
    click_link "My techniques"
    click_link "White (mu kup)"
    click_link "Peek"
    click_link "Unpeek"

    expect(page).not_to have_content "Front kick"
  end
end
