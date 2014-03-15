require 'spec_helper'

feature "editing notes" do
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
