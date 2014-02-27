require 'spec_helper'

feature "managing techniques" do
  let(:technique) { build :technique }

  feature 'creating techniques' do
    scenario 'a user creates a technique' do
      sign_up
      create_technique technique

      expect(page).to have_content "Technique saved"
      expect(page).to have_content technique.name
    end

    scenario 'a user creates an invalid technique' do
      technique = build :technique, name: ""
      sign_up
      create_technique technique

      expect(page).to have_content "Technique not valid"
    end
  end

  feature 'viewing techniques' do
    before do
      sign_up
    end

    scenario "a user views his list of techniques using another grouping", js: true do
      technique = build :technique,
        name: "Ap chagi",
        description: "description",
        belt: create(:belt, color: "white", degree: "mu kup"),
        category: create(:category, name: "Jokgi sul")

      create_technique technique
      click_link "Techniques"
      select 'Belt then category', from: 'groupings'

      expect(page.body).to match /White \(mu kup\).*Jokgi Sul.*Ap chagi/mi
    end

    scenario "A user sees that the list is sorted" do
      create_technique build :technique, name: "Gibon sul 10"
      create_technique build :technique, name: "Gibon sul 2"
      create_technique build :technique, name: "Gibon sul 1"
      click_link "Techniques"

      expect(page.body).to match /Gibon sul 1.*Gibon sul 2.*Gibon sul 10/mi
    end

    scenario 'a user views a single technique' do
      create_technique technique
      visit root_path
      click_link "Techniques"
      click_link technique.name

      expect(page).to have_content technique.name
    end
  end

  feature 'updating techniques' do
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

    scenario "a user updates a technique" do
      sign_up
      create_technique technique
      click_link "Techniques"
      click_link technique.name
      click_link "Edit"
      fill_in "Name", with: ""
      click_button "Update"

      expect(page).to have_content "Technique not updated"
    end
  end

  feature "deleting techniques" do
    scenario "a user deletes a technique" do
      sign_up
      create_technique technique
      click_link "Techniques"
      click_link technique.name
      click_link "Delete"
      click_link "Techniques"

      expect(page).not_to have_content "Ap chagi"
    end
  end
end
