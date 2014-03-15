require 'spec_helper'

feature 'viewing list of questions' do
  scenario 'user sees his questions' do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"
    click_link "Questions"

    expect(page).to have_content "Text of the new note"
  end
end
