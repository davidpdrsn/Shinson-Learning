require 'spec_helper'

feature 'creating techniques' do
  scenario 'a user creates a technique' do
    sign_up
    create_technique("Ap chagi")

    expect(page).to have_content "Technique saved"
    expect(page).to have_content "Ap chagi"
  end

  scenario 'a user creates an invalid technique' do
    sign_up
    create_technique("")

    expect(page).to have_content "Technique not valid"
  end
end

feature 'viewing techniques' do
  before do
    sign_up
  end

  scenario 'a user view his list of techniques with the default grouping' do
    create_technique("Ap chagi", "description", "White (mu kup)", "Jokgi sul")
    click_link "Techniques"

    expect(page).to have_content "Ap chagi"
  end

  scenario "a user views his list of techniques using another grouping", js: true do
    create_technique("Ap chagi", "description", "White (mu kup)", "Jokgi sul")
    click_link "Techniques"
    select 'Belt then category', from: 'groupings'

    expect(page.body).to match /White \(mu kup\).*Jokgi Sul.*Ap chagi/mi
  end

  scenario "A user sees that the list is sorted" do
    create_technique("Gibon sul 10")
    create_technique("Gibon sul 2")
    create_technique("Gibon sul 1")
    click_link "Techniques"

    expect(page.body).to match /Gibon sul 1.*Gibon sul 2.*Gibon sul 10/mi
  end

  scenario 'a user views a single technique' do
    create_technique("Ap chagi")
    visit root_path
    click_link "Techniques"
    click_link "Ap chagi"

    expect(page).to have_content "Ap chagi"
  end
end

feature 'updating techniques' do
  scenario "a user updates a technique" do
    sign_up
    create_technique("Ap chagi")
    click_link "Techniques"
    click_link "Ap chagi"
    click_link "Edit"
    fill_in "Name", with: "Dollyo chagi"
    click_button "Update"

    expect(page).to have_content "Dollyo chagi"
  end

  scenario "a user updates a technique" do
    sign_up
    create_technique("Ap chagi")
    click_link "Techniques"
    click_link "Ap chagi"
    click_link "Edit"
    fill_in "Name", with: ""
    click_button "Update"

    expect(page).to have_content "Technique not updated"
  end
end

feature "deleting techniques" do
  scenario "a user deletes a technique" do
    sign_up
    create_technique("Ap chagi")
    click_link "Techniques"
    click_link "Ap chagi"
    click_link "Delete"
    click_link "Techniques"

    expect(page).not_to have_content "Ap chagi"
  end
end
