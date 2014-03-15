require 'spec_helper'

feature 'navigating from question to technique' do
  scenario 'user sees the technique' do
    technique = build :technique
    sign_up
    create_technique technique
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"
    click_link "Questions"
    click_link technique.name

    expect(page).to have_content technique.description
  end
end
