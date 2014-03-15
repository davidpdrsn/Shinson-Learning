require 'spec_helper'

feature 'peaking at techniques' do
  let(:belt) { create :belt, color: "white", degree: "Mu kup" }
  let(:category) { create :category }

  let :technique do
    build :technique,
          name: "Ap chagi",
          description: "Front kick",
          belt: belt,
          category: category
  end

  let :another_technique do
    build :technique,
          name: "Yop chagi",
          description: "Side kick",
          belt: belt,
          category: category
  end

  scenario "a user peeks at a technique", js: true do
    sign_up
    create_technique technique
    visit root_path
    click_link "Techniques"
    click_link "White (mu kup)"
    click_link "Peek"

    expect(page).to have_selector '.technique__description', visible: true, text: "Front kick"
  end

  scenario "a user peeks and then unpeeks", js: true do
    sign_up
    create_technique technique
    visit root_path
    click_link "Techniques"
    click_link "White (mu kup)"
    click_link "Peek"

    expect(page).to have_selector '.technique__description', visible: false, text: "Front kick"
  end

  scenario "a user peeks at all his techniques", js: true do
    sign_up
    create_technique technique
    create_technique another_technique
    visit root_path
    click_link "Techniques"
    click_link "Peek all"

    within ".techniques li:first-of-type" do
      expect(page).to have_selector '.technique__description', visible: true, text: "Front kick"
    end

    within ".techniques li:last-of-type" do
      expect(page).to have_selector '.technique__description', visible: true, text: "Side kick"
    end
  end
end
