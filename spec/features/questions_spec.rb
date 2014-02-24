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

  scenario 'user views his list of questions' do
    sign_up
    create_technique("Ap Chagi")
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"
    click_link "Questions"

    expect(page).to have_content "Text of the new note"
  end

  scenario 'a user navigates to a technique from the question' do
    sign_up
    create_technique("Ap Chagi", "technique description")
    fill_in "Note text", with: "Text of the new note"
    check "Question?"
    click_button "Create Note"
    click_link "Questions"
    click_link "Ap Chagi"

    expect(page).to have_content "technique description"
  end
end
