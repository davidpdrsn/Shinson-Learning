require 'spec_helper'

feature 'creating techniques' do
  scenario 'a user creates a technique' do
    sign_up
    create_technique

    expect(page).to have_content "Technique saved"
  end

  scenario 'a user creates an invalid technique' do
    sign_up
    create_technique("")

    expect(page).to have_content "Technique not valid"
  end
end

feature 'viewing techniques' do
  scenario 'a user view his list of todos' do
    sign_up
    create_technique
    click_link "My techniques"

    expect(page).to have_content "Ap chagi"
  end
end
