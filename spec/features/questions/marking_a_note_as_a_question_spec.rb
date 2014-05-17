require 'spec_helper'

feature 'marking a note as a question' do
  scenario 'user sees that the note is now a question' do
    sign_up
    technique = create_technique
    add_note_to technique, build(:question)

    expect(page).to have_content "This note is a question"
  end
end
