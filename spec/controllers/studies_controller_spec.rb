require 'spec_helper'

describe StudiesController do
  describe "index" do
    it "assigns studies" do
      study = create :study
      sign_in study.user
      get :index

      expect(assigns(:studies)).to eq [study]
    end

    it "requires authentication" do
      get :index

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#show" do
    it "assigns @study" do
      study = create :study
      sign_in study.user
      get :show, id: study.id

      expect(assigns(:study)).to eq study
    end

    it "requires authentication" do
      get :show, id: 1

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#new" do
    it "assigns @study" do
      user = create :user
      sign_in user
      get :new

      expect(assigns(:study)).to be_a_new_record
      expect(assigns(:study).user).to eq user
    end

    it "requires authentication" do
      get :new

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#create" do
    it "creates the study" do
      Study.any_instance.stub(:valid?) { true }

      user = create :user
      sign_in user
      belt = create :belt
      category = create :category

      expect do
        post :create, study: { category_id: category.id, belt_id: belt.id }
      end.to change { user.studies.count }.by 1

      expect(subject).to redirect_to Study.last
    end

    it "doesn't create the study if its invalid" do
      Study.any_instance.stub(:valid?) { false }

      user = create :user
      sign_in user
      belt = create :belt
      category = create :category

      expect do
        post :create, study: { category_id: category.id, belt_id: belt.id }
      end.not_to change { user.studies.count }

      expect(subject).to render_template :new
    end

    it "requires authentication" do
      post :create

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
