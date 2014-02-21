require 'spec_helper'

describe NotesController, "POST #create" do
  context "user is signed in" do
    it "creates the note" do
      user = create(:user)
      technique = create(:technique, user: user)
      sign_in user
      attributes = attributes_for(:note)

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.to change { Note.count }.by 1

      expect(subject).to set_the_flash[:notice]
      expect(Note.last.technique).to eq technique
      expect(Note.last.user).to eq user
    end

    it "doesn't create the note if it is invalid" do
      user = create(:user)
      technique = create(:technique, user: user)
      sign_in user
      attributes = attributes_for(:note, text: "")

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.not_to change { Note.count }

      expect(subject).to set_the_flash[:alert]
    end

    it "doesn't create the note if the user doesn't own the technique" do
      user = create(:user)
      sign_in user
      another_user = create(:user)
      technique = create(:technique, user: another_user)
      attributes = attributes_for(:note)

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.not_to change { Note.count }

      expect(subject).to set_the_flash[:alert]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)
      attributes = attributes_for(:note)

      post :create, note: attributes, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
