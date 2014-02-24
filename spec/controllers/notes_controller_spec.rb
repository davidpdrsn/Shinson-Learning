require 'spec_helper'

# TODO: refactor this!

describe NotesController, "POST #create" do
  context "user is signed in" do
    it "creates the note" do
      user = create(:user)
      technique = create(:technique, user: user)
      sign_in user
      attributes = attributes_for(:question)

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.to change { user.notes.count + technique.notes.count }.by 2

      expect(subject).to set_the_flash[:notice]
      expect(subject).to redirect_to technique
      expect(Note.last).to be_question
    end

    it "doesn't create the note if it is invalid" do
      user = create(:user)
      technique = create(:technique, user: user)
      sign_in user
      attributes = attributes_for(:note, text: "")

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.not_to change { user.notes.count + technique.notes.count }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to technique
    end

    it "doesn't create the note if the user doesn't own the technique" do
      user = create(:user)
      sign_in user
      another_user = create(:user)
      technique = create(:technique, user: another_user)
      attributes = attributes_for(:note)

      expect do
        post :create, note: attributes, technique_id: technique.id
      end.not_to change { user.notes.count + technique.notes.count }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to root_path
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)
      attributes = attributes_for(:note)

      post :create, note: attributes, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe NotesController, "GET #edit" do
  context "user is signed in" do
    it "assigns @note" do
      user = create(:user)
      sign_in user
      technique = create(:technique, user: user)
      note = create(:note, technique: technique, user: user)

      get :edit, id: note.id, technique_id: technique.id

      expect(assigns(:note)).to eq note
      expect(subject).to render_template :edit
    end

    it "doesn't let a user edit another users note" do
      user = create(:user)
      sign_in user
      another_user = create(:user)
      technique = create(:technique, user: another_user)
      note = create(:note, technique: technique, user: another_user)

      get :edit, id: note.id, technique_id: technique.id

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to root_path
    end
  end

  it "requires authentication" do
    technique = create(:technique)
    note = create(:note, technique: technique)

    get :edit, id: note.id, technique_id: technique.id

    expect(subject).to set_the_flash[:alert]
    expect(subject).to redirect_to new_user_session_path
  end
end

describe NotesController, "PATCH #update" do
  context "user is signed in" do
    it "updates the note" do
      user = create(:user)
      sign_in user
      technique = create(:technique, user: user)
      note = create(:note, technique: technique, user: user)

      patch :update, id: note.id, technique_id: technique.id, note: { text: "New text" }

      expect(subject).to set_the_flash[:notice]
      expect(subject).to redirect_to technique
    end

    it "doesn't update the note if the data is invalid" do
      user = create(:user)
      sign_in user
      technique = create(:technique, user: user)
      note = create(:note, technique: technique, user: user)

      patch :update, id: note.id, technique_id: technique.id, note: { text: "" }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to technique
    end

    it "doesn't update the note if the user doesn't own it" do
      user = create(:user)
      sign_in user
      another_user = create(:user)
      technique = create(:technique, user: another_user)
      note = create(:note, technique: technique, user: another_user)

      patch :update, id: note.id, technique_id: technique.id, note: { text: "" }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to root_path
    end
  end

  it "requires authentication" do
    technique = create(:technique)
    note = create(:note, technique: technique)

    patch :update, id: note.id, technique_id: technique.id

    expect(subject).to redirect_to new_user_session_path
    expect(subject).to set_the_flash[:alert]
  end
end

describe NotesController, "DELETE #destory" do
  context "as a signed in user" do
    it "deletes the note" do
      user = create(:user)
      technique = create(:technique, user: user)
      note = create(:note, technique: technique, user: user)
      sign_in user

      expect do
        delete :destroy, id: note.id, technique_id: technique.id
      end.to change { user.notes.count + technique.notes.count }.by -2

      expect(subject).to set_the_flash[:notice]
      expect(subject).to redirect_to technique
    end

    it "doesn't delete the note if the user doesn't own it" do
      user = create(:user)
      another_user = create(:user)
      technique = create(:technique, user: another_user)
      note = create(:note, technique: technique, user: another_user)
      sign_in user

      expect do
        delete :destroy, id: note.id, technique_id: technique.id
      end.not_to change { user.notes.count + technique.notes.count }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to redirect_to root_path
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)
      note = create(:note, technique: technique)

      delete :destroy, id: note.id, technique_id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end
end
