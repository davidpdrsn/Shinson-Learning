require 'spec_helper'

feature 'questions' do
  scenario 'user marks a note as a question' do
    sign_up
    create_technique("Ap Chagi")
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"

    within ".notes__list" do
      expect(page).to have_content "This note is a question"
    end
  end
end
