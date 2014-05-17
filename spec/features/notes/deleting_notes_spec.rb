require 'spec_helper'

feature "deleting notes" do
  scenario "a user deletes a note" do
    sign_up
    technique = create_technique
    add_note_to technique, build(:note, text: "Text of new note")
    click_link "Delete note"

    expect(page).not_to have_content "Text of new note"
  end
end
