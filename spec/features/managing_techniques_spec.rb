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
  scenario 'a user view his list of techniques' do
    sign_up
    create_technique("Ap chagi", "description", "White (mu kup)", "Jokgi sul")
    create_technique("Dollyo chagi", "description", "Red/Brown (4. kup)", "Jokgi sul")
    create_technique("Sujang chigi", "description", "Yellow (9. kup)", "Sugi sul")
    create_technique("Monkey hyong", "description", "Black (1. dan)", "Hyong")
    click_link "My techniques"

    within ".jokgi-sul" do
      within ".white" do
        expect(page).to have_content "Ap chagi"
      end

      within ".red-brown" do
        expect(page).to have_content "Dollyo chagi"
      end
    end

    within ".sugi-sul" do
      within ".yellow" do
        expect(page).to have_content "Sujang chigi"
      end
    end

    within ".hyong" do
      within ".black" do
        expect(page).to have_content "Monkey hyong"
      end
    end
  end
end
