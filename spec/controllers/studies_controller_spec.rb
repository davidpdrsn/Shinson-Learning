require 'spec_helper'

describe StudiesController do
  let(:study) { create :study }
  let(:user) { study.user }

  describe "index" do
    it "assigns studies" do
      sign_in user
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
      sign_in user
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
      user = create :user
      sign_in user
      4.times { create :technique, user: user }

      post :create, study: { name: "foo", technique_ids: user.techniques.map(&:id).join(",") }

      Study.last.techniques.should =~ user.techniques
      Study.last.name.should == "foo"
      Study.last.techniques.count.should eq 4
      expect(user.studies.count).to eq 1
      expect(subject).to redirect_to Study.last
    end

    it "doesn't create the study if its invalid" do
      Study.any_instance.stub(:valid?) { false }
      user = create :user
      sign_in user

      post :create, study: { name: nil, technique_ids: nil }

      expect(subject).to render_template :new
    end

    it "requires authentication" do
      post :create

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "study" do
    context "as a signed in user" do
      before { sign_in user }

      context "with an html request" do
        it "assigns @study" do
          get :study, id: study.id

          expect(assigns(:study)).to eq study
        end
      end

      context "with a json request" do
        it "responds with the study and its techniques" do
          get :study, id: study.id, format: :json

          json = JSON.parse response.body
          expect(json["study"]["id"]).to eq study.id
          expect(json["techniques"].length).to eq study.techniques.length
        end
      end
    end

    it "requires authentication" do
      get :study, id: 1

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#edit" do
    it "requires authentication" do
      get :edit, id: 1

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#update" do
    context "as a signed in user" do
      let(:study) { create :study, name: "name" }
      before { sign_in study.user }

      it "updates the study" do
        patch :update, id: study.id, study: { name: "new name" }

        expect(Study.last.name).to eq "new name"
        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to Study.last
      end

      it "doesn't update the study if its invalid" do
        Study.any_instance.stub(:valid?).and_return(false)

        patch :update, id: study.id, study: { name: "" }

        expect(Study.last.name).to eq "name"
        expect(subject).to render_template :edit
      end

      it "doesn't a user update other users studies" do
        patch :update, id: create(:study).id, study: { name: "new_name" }

        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      patch :update, id: 1, study: attributes_for(:study)

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#destroy" do
    context "as a signed in user" do
      before { sign_in user }

      it 'destroys the study' do
        expect do
          delete :destroy, id: study.id
        end.to change { user.studies.count }.by -1

        expect(subject).to redirect_to studies_path
        expect(subject).to set_the_flash[:notice]
      end

      it "doesn't let a user destroy another users study" do
        another_user = create :user
        sign_in another_user

        expect do
          delete :destroy, id: study.id
        end.not_to change { user.studies.count }

        expect(subject).to redirect_to root_path
        expect(subject).to set_the_flash[:alert]
      end
    end

    it "requires authentication" do
      delete :destroy, id: 1

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
