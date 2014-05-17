require 'spec_helper'

feature 'viewing list of questions' do
  scenario 'user sees his questions' do
    sign_up
    create_technique
    technique = create_technique
    add_note_to technique, build(:question, text: "Text of the new note")
    click_link "Questions"

    expect(page).to have_content "Text of the new note"
  end
end
