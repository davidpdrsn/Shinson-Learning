require 'spec_helper'

feature 'marking a note as a question' do
  scenario 'user sees that the note is now a question' do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"

    expect(page).to have_content "This note is a question"
  end
end
