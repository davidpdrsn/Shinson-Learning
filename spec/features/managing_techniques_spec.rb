require 'spec_helper'

feature 'creating techniques' do
  before do
    create(:belt, color: "White", degree: "Mu kup")
    create(:category, name: "Jokgi sul")
  end

  scenario 'a user creates a technique' do
    sign_up
    click_link "New technique"
    fill_in "Name", with: "Ap Chagi"
    fill_in "Description", with: "Front kick"
    select "White (mu kup)", from: "Belt"
    select "Jokgi sul", from: "Category"
    click_button "Create Technique"

    expect(page).to have_content "Technique saved"
  end

  scenario 'a user creates an invalid technique' do
    sign_up
    click_link "New technique"
    fill_in "Name", with: ""
    fill_in "Description", with: "Front kick"
    select "White (mu kup)", from: "Belt"
    select "Jokgi sul", from: "Category"
    click_button "Create Technique"

    expect(page).to have_content "Technique not valid"
  end
end

feature 'viewing techniques' do
  before do
    create(:belt, color: "White", degree: "Mu kup")
    create(:category, name: "Jokgi sul")
  end

  scenario 'a user view his list of todos' do
    sign_up
    click_link "New technique"
    fill_in "Name", with: "Ap chagi"
    fill_in "Description", with: "Front kick"
    select "White (mu kup)", from: "Belt"
    select "Jokgi sul", from: "Category"
    click_button "Create Technique"
    click_link "My techniques"

    expect(page).to have_content "Ap chagi"
  end
end
