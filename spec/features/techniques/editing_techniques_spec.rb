require 'spec_helper'

feature 'updating techniques' do
  let(:technique) { build :technique }

  scenario "a user updates a technique" do
    sign_up
    create_technique technique
    click_link "Techniques"
    click_link technique.name
    click_link "Edit"
    fill_in "Name", with: "Dollyo chagi"
    click_button "Update"

    expect(page).to have_content "Dollyo chagi"
  end

  scenario "user tries to update it with invalid data" do
    sign_up
    create_technique technique
    click_link "Techniques"
    click_link technique.name
    click_link "Edit"
    fill_in "Name", with: ""
    click_button "Update"

    expect(page).to have_content "Please review the problems"
  end
end
