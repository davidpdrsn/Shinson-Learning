require 'spec_helper'

feature 'creating techniques' do
  scenario 'a logged in user creates a technique' do
    create(:belt, color: "White", degree: "Mu kup")
    create(:category, name: "Jokgi sul")

    sign_up
    click_link "New technique"
    fill_in "Name", with: "Ap Chagi"
    fill_in "Description", with: "Front kick"
    select "White (mu kup)", from: "Belt"
    select "Jokgi sul", from: "Category"
    click_button "Create Technique"

    expect(page).to have_content "Technique saved"
  end
end
