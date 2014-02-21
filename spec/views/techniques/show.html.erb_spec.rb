require 'spec_helper'

describe "techniques/show" do
  let(:user) { build_stubbed(:user) }

  before do
    controller.stub(:current_user).and_return(user)
  end

  it "shows links to edit and destroy the technique if the user owns it" do
    technique = build_stubbed(:technique, user: user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    assign(:notes, [])

    with_rendered_page do |page|
      expect(page).to have_content "Edit"
      expect(page).to have_content "Delete"
    end
  end

  it "doesn't shows links to edit and destroy the technique if the user doesn't own it" do
    technique = build_stubbed(:technique)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    assign(:notes, [])

    with_rendered_page do |page|
      expect(page).not_to have_content "Edit"
      expect(page).not_to have_content "Delete"
    end
  end

  it "shows a list of notes" do
    technique = build_stubbed(:technique)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    note = build_stubbed(:note, technique: technique)
    assign(:notes, [note])

    with_rendered_page do |page|
      expect(page).to have_content note.text
    end
  end

  it "shows when there are no notes" do
    technique = build_stubbed(:technique)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    assign(:notes, [])

    with_rendered_page do |page|
      expect(page).to have_content "There are no notes for this technique"
    end
  end

  it "shows the form for creating a note" do
    technique = build_stubbed(:technique, user: user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)

    with_rendered_page do |page|
      expect(page).to have_button "Create Note"
    end
  end

  it "doesn't show the form for creating a new note when the user doesn't own it" do
    another_user = build_stubbed(:user)
    controller.stub(:current_user).and_return(another_user)
    technique = build_stubbed(:technique, user: user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)

    with_rendered_page do |page|
      expect(page).not_to have_button "Create Note"
    end
  end

  it "shows link to delete notes" do
    technique = build_stubbed(:technique, user: user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    note = build_stubbed(:note, technique: technique)
    assign(:notes, [note])

    with_rendered_page do |page|
      expect(page).to have_content "Delete note"
    end
  end

  it "doesn't show a link to delete the note if the user doesn't own it" do
    technique = build_stubbed(:technique, user: user)
    another_user = build_stubbed(:user)
    controller.stub(:current_user).and_return(another_user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    note = build_stubbed(:note, technique: technique)
    assign(:notes, [note])

    with_rendered_page do |page|
      expect(page).not_to have_content "Delete note"
    end
  end

  it "shows a link a to edit the note" do
    technique = build_stubbed(:technique, user: user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    note = build_stubbed(:note, technique: technique)
    assign(:notes, [note])

    with_rendered_page do |page|
      expect(page).to have_content "Edit note"
    end
  end

  it "doesn't show a link to edit the note if the user doesn't own the note" do
    technique = build_stubbed(:technique, user: user)
    another_user = build_stubbed(:user)
    controller.stub(:current_user).and_return(another_user)
    assign(:new_note, technique.notes.new)
    assign(:technique, technique)
    note = build_stubbed(:note, technique: technique)
    assign(:notes, [note])

    with_rendered_page do |page|
      expect(page).not_to have_content "Edit note"
    end
  end
end
