require 'spec_helper'

describe TechniquesController, "GET #index" do
  context "as a signed in user" do
    it "assigns @techniques to the users techniques" do
      user = create(:user)
      sign_in user
      technique1 = create(:technique, user: user)
      technique2 = create(:technique)
      technique3 = create(:technique, user: user)

      get :index

      expect(assigns(:techniques)).to eq [technique1, technique3]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      get :index

      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe TechniquesController, "GET #show" do
  it "assigns @technique" do
    technique = create(:technique)

    get :show, id: technique.id

    expect(assigns(:technique)).to eq technique
  end
end

describe TechniquesController, "GET #new" do
  context "as a signed in user" do
    it "assigns @techniques as a new technique for the user" do
      user = create(:user)
      sign_in user

      get :new

      expect(assigns(:technique)).to be_new_record
      expect(assigns(:technique).user).to eq user
    end
  end

  context "as a guest" do
    it "requires authentication" do
      get :new

      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe TechniquesController, "POST #create" do
  context "as a signed in user" do
    it "creates a new technique" do
      user = create(:user)
      sign_in user
      attributes = attributes_for(:technique)

      expect do
        post :create, technique: attributes
      end.to change { Technique.count }

      expect(subject).to set_the_flash[:notice]
      expect(Technique.first.user).to eq user
    end

    it "doesn't create a new technique if the data is invalid" do
      user = create(:user)
      sign_in user
      attributes = attributes_for(:technique, name: "")

      expect do
        post :create, technique: attributes
      end.not_to change { Technique.count }

      expect(subject).to set_the_flash[:alert]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      post :create, technique: {}

      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe TechniquesController, "GET #edit" do
  context "as a signed in user" do
    it "assigns @technique" do
      technique = create(:technique)
      sign_in technique.user

      get :edit, id: technique.id

      expect(assigns(:technique)).to eq technique
    end

    it "doesn't let a user edit other users techniques" do
      technique = create(:technique)
      another_technique = create(:technique)
      sign_in technique.user

      get :edit, id: another_technique.id

      expect(subject).to set_the_flash[:alert]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)

      get :edit, id: technique.id

      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe TechniquesController, "PATCH #update" do
  context "as a signed in user" do
    it "updates the technique" do
      technique = create(:technique)
      sign_in technique.user

      patch :update, id: technique.id, technique: { name: "foo" }

      expect(subject).to set_the_flash[:notice]
    end

    it "doesn't update the technique if the data is invalid" do
      technique = create(:technique)
      sign_in technique.user

      patch :update, id: technique.id, technique: { name: "" }

      expect(subject).to set_the_flash[:alert]
    end

    it "doesn't allow users to update other users techniques" do
      technique = create(:technique)
      sign_in technique.user
      another_technique = create(:technique)

      patch :update, id: another_technique.id, technique: { name: "foo" }

      expect(subject).to set_the_flash[:alert]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)

      patch :update, id: technique.id, technique: { name: "foo" }

      expect(subject).to redirect_to new_user_session_path
    end
  end
end

describe TechniquesController, "DELETE #destroy" do
  context "as a signed in user" do
    it "destroys the technique" do
      technique = create(:technique)
      sign_in technique.user

      expect do
        delete :destroy, id: technique.id
      end.to change { Technique.count }.by -1

      expect(subject).to set_the_flash[:notice]
    end

    it "doesn't let a user destroy another users techniques" do
      technique = create(:technique)
      sign_in technique.user
      another_technique = create(:technique)

      expect do
        delete :destroy, id: another_technique.id
      end.not_to change { Technique.count }

      expect(subject).to set_the_flash[:alert]
    end
  end

  context "as a guest" do
    it "requires authentication" do
      technique = create(:technique)

      delete :destroy, id: technique.id

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
