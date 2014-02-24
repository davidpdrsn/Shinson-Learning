require 'spec_helper'

feature 'peaking at techniques' do
  scenario "a user peeks at a technique", js: true do
    sign_up
    create_technique("Ap chagi", "Front kick", "White (mu kup)")
    visit root_path
    click_link "My techniques"
    click_link "White (mu kup)"
    click_link "Peek"

    expect(page).to have_selector '.technique__description', visible: true, text: "Front kick"
  end

  scenario "a user peeks and then unpeeks", js: true do
    sign_up
    create_technique("Ap chagi", "Front kick", "White (mu kup)")
    visit root_path
    click_link "My techniques"
    click_link "White (mu kup)"
    click_link "Peek"

    expect(page).to have_selector '.technique__description', visible: false, text: "Front kick"
  end
end

feature "peeking at all techniques" do
  scenario "a user peeks at all his techniques", js: true do
    sign_up
    create_technique("Ap chagi", "Front kick", "White (mu kup)")
    create_technique("Yop chagi", "Side kick", "White (mu kup)")
    visit root_path
    click_link "My techniques"
    click_link "Peek all"

    within ".techniques li:first-of-type" do
      expect(page).to have_selector '.technique__description', visible: true, text: "Front kick"
    end

    within ".techniques li:last-of-type" do
      expect(page).to have_selector '.technique__description', visible: true, text: "Side kick"
    end
  end
end
