require 'spec_helper'

feature 'navigating from question to technique' do
  scenario 'user sees the technique' do
    technique = build :technique
    sign_up
    technique = create_technique
    add_note_to technique, build(:question)

    click_link "Questions"
    click_link technique.name

    expect(page).to have_content technique.description
  end
end
