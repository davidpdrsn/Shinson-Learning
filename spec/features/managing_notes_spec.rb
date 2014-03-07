require 'spec_helper'

feature "adding a note to a technique" do
  scenario "a user adds a note to one of his techniques" do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    click_button "Create Note"

    expect(page).to have_content "Text of the new note"
  end

  scenario "a user creates an invalid note, then fixes it" do
    sign_up
    create_technique
    fill_in "Note text", with: ""
    click_button "Create Note"
    fill_in "Note text", with: "Text of the note"
    click_button "Create Note"

    expect(page).to have_content "Text of the note"
  end
end

feature "editing a note" do
  scenario "a user edits a note" do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    click_button "Create Note"
    click_link "Edit note"
    fill_in "Note text", with: "new note text"
    click_button "Update Note"

    expect(page).to have_content "new note text"
  end
end

feature "deleting notes" do
  scenario "a user deletes a note" do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    click_button "Create Note"
    click_link "Delete note"

    expect(page).not_to have_content "Text of the new note"
  end
end
