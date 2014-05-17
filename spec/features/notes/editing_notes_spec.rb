require 'spec_helper'

feature "editing notes" do
  scenario "a user edits a note" do
    sign_up
    technique = create_technique
    add_note_to technique, build(:note, text: "Text of new note")
    click_link "Edit note"
    fill_in "Note text", with: "new note text"
    click_button "Update Note"

    expect(page).to have_content "new note text"
  end
end
