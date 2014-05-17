require 'spec_helper'

feature "adding notes to techniques" do
  scenario "a user adds a note to one of his techniques" do
    sign_up
    technique = create_technique
    add_note_to technique, build(:note, text: "Text of new note")

    expect(page).to have_content "Text of new note"
  end
end

