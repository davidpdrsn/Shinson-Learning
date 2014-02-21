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

  scenario 'a user view his list of techniques' do
    create_technique("Ap chagi", "description", "White (mu kup)", "Jokgi sul")
    click_link "My techniques"

    expect(page).to have_content "Ap chagi"
  end

  scenario 'a user views a single technique' do
    create_technique("Ap chagi")
    visit root_path
    click_link "My techniques"
    click_link "Ap chagi"

    expect(page).to have_content "Ap chagi"
  end
end
