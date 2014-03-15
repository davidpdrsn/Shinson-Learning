require 'spec_helper'

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
