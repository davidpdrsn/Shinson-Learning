require 'spec_helper'

feature "Exporting" do
  scenario "exporting some techniques" do
    user = create :user
    belt = create :belt
    another_belt = create :belt
    category = create :category

    technique = create :technique, user: user, belt: belt, category: category
    another_technique = create :technique, user: user, belt: another_belt, category: category

    sign_in user

    visit root_path
    click_link "Export techniques"
    check belt.pretty_print
    check category.name
    click_button "Export"

    expect(page).to have_content technique.name
    expect(page).to_not have_content another_technique.name

    bookmark = current_url
    visit root_path
    visit bookmark

    expect(page).to have_content technique.name
    expect(page).to_not have_content another_technique.name
  end
end
