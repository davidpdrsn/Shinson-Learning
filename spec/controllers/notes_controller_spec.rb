require 'spec_helper'

describe NotesController do
  let(:user) { create :user }
  let(:technique) { create :technique, user: user }
  let(:attr) { attributes_for(:question) }
  let(:invalid_attr) { attributes_for(:question, text: "") }
  let!(:note) { create(:note, technique: technique, user: user) }
  let(:another_user) { create :user }
  let(:another_technique) { create :technique, user: another_user }

  describe "#create" do
    context "when signed in" do
      before { sign_in user }

      it "creates a note" do
        expect do
          post :create, note: attr, technique_id: technique.id
        end.to change { user.notes.count + technique.notes.count }.by 2

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to technique
        expect(Note.last).to be_question
      end

      it "create the note if its invalid" do
        expect do
          post :create, note: invalid_attr, technique_id: technique.id
        end.not_to change { user.notes.count + technique.notes.count }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to technique
      end

      it "doesn't create the note if the techniques belongs to another user" do
        expect do
          post :create, note: attr, technique_id: another_technique.id
        end.not_to change { user.notes.count + technique.notes.count }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      post :create, note: attr, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#edit" do
    context "when signed in" do
      before { sign_in user }

      it "assigns note" do
        get :edit, id: note.id, technique_id: technique.id

        expect(assigns(:note)).to eq note
        expect(subject).to render_template :edit
      end

      it "doesn't let a user edit another users note" do
        get :edit, id: note.id, technique_id: another_technique.id

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      get :edit, id: note.id, technique_id: technique.id

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#update" do
    context "user is signed in" do
      before { sign_in user }

      it "updates the note" do
        patch :update, id: note.id, technique_id: technique.id, note: { text: "New text" }

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to technique
      end

      it "doesn't update the note if the data is invalid" do
        patch :update, id: note.id, technique_id: technique.id, note: { text: "" }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to technique
      end

      it "doesn't update the note if the user doesn't own it" do
        patch :update, id: note.id, technique_id: another_technique.id, note: { text: "" }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      patch :update, id: note.id, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#destroy" do
    context "as a signed in user" do
      before { sign_in user }

      it "deletes the note" do
        expect do
          delete :destroy, id: note.id, technique_id: technique.id
        end.to change { user.notes.count + technique.notes.count }.by -2

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to technique
      end

      it "doesn't delete the note if the user doesn't own it" do
        expect do
          delete :destroy, id: note.id, technique_id: another_technique.id
        end.not_to change { user.notes.count + technique.notes.count }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      delete :destroy, id: note.id, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end
end
