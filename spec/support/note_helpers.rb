def add_note_to technique, note = build(:note)
  visit technique_path(technique)
  click_link "Add note"
  fill_in "Note text", with: note.text
  check "Question?" if note.question?

  click_button "Create Note"

  Note.last
end
