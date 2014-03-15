require 'spec_helper'

feature 'creating techniques' do
  let(:technique) { build :technique }

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

    expect(page).to have_content "Please review the problems"
  end
end
