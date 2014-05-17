require 'spec_helper'

describe "techniques/show" do
  let(:user) { build_stubbed(:user) }

  before do
    assign(:technique_cache, double.as_null_object)
    controller.stub(:current_user).and_return(user)
    view.stub(:timestamp)
  end

  context "when the user owns the technique" do
    let(:technique) { build_stubbed(:technique, user: user) }

    before do
      assign(:note, technique.notes.new)
      assign(:technique, technique)
      assign(:notes, [])
    end

    it "shows links to edit and destroy" do
      with_rendered_page do |page|
        expect(page).to have_content "Edit"
        expect(page).to have_content "Delete"
      end
    end

    it "shows the form for creating a note" do
      with_rendered_page do |page|
        expect(page).to have_link "Add note"
      end
    end
  end

  context "when the user doesn't own the technique" do
    it "doesn't shows links to edit and destroy" do
      technique = build_stubbed(:technique)
      assign(:note, technique.notes.new)
      assign(:technique, technique)
      assign(:notes, [])

      with_rendered_page do |page|
        expect(page).not_to have_content "Edit"
        expect(page).not_to have_content "Delete"
      end
    end

    it "doesn't show the form for creating a new note" do
      another_user = build_stubbed(:user)
      controller.stub(:current_user).and_return(another_user)
      technique = build_stubbed(:technique, user: user)
      assign(:note, technique.notes.new)
      assign(:technique, technique)

      with_rendered_page do |page|
        expect(page).not_to have_link "Add note"
      end
    end
  end

  describe "notes" do
    let(:technique) { build_stubbed(:technique) }
    let(:note) { build_stubbed(:note, technique: technique) }

    before do
      assign(:note, technique.notes.new)
      assign(:technique, technique)
    end

    context "when there are notes" do
      before { assign(:notes, [note]) }

      it "shows the notes" do
        with_rendered_page do |page|
          expect(page).to have_content note.text
        end
      end

      context "the user owns the technique" do
        let(:technique) { build_stubbed(:technique, user: user) }

        it "shows link to delete notes" do
          with_rendered_page do |page|
            expect(page).to have_content "Delete note"
          end
        end

        it "shows a link a to edit the note" do
          with_rendered_page do |page|
            expect(page).to have_content "Edit note"
          end
        end
      end

      context "the user doesn't own the technique" do
        it "doesn't show a link to delete the note if the user doesn't own it" do
          with_rendered_page do |page|
            expect(page).not_to have_content "Delete note"
          end
        end

        it "doesn't show a link to edit the note if the user doesn't own the note" do
          with_rendered_page do |page|
            expect(page).not_to have_content "Edit note"
          end
        end
      end

      context "when the note is a question" do
        let(:note) { build_stubbed(:question, technique: technique) }

        it "shows if the note is a question" do
          with_rendered_page do |page|
            expect(page).to have_content "This note is a question"
          end
        end
      end

      context "when the note is not a question" do
        it "shows if the note is not a question" do
          with_rendered_page do |page|
            expect(page).not_to have_content "This note is a question"
          end
        end
      end
    end

    context "when there are no notes" do
      it "shows that there are no notes" do
        assign(:notes, [])

        with_rendered_page do |page|
          expect(page).to have_content "There are no notes for this technique"
        end
      end
    end
  end
end
