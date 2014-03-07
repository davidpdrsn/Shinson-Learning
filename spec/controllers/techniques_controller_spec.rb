require 'spec_helper'

describe TechniquesController do
  let(:user) { create(:user) }
  let(:technique) { create :technique, user: user }
  let(:another_technique) { create :technique }
  let(:attr) { build(:technique, user: user).attributes }
  let(:invalid_attr) { build(:technique, name: "", user: user).attributes }

  describe "#index" do
    context "when signed in" do
      before do
        Technique.stub(:for_user_grouped_by)
        sign_in user
        get :index
      end

      it "assigns @techniques" do
        expect(Technique).to have_received :for_user_grouped_by
      end

      it "assigns @page_title" do
        expect(assigns(:page_title)).to eq "Techniques"
      end
    end

    it "requires authentication" do
      get :index

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#show" do
    before { get :show, id: technique.id }

    it "assigns @technique" do
      expect(assigns(:technique)).to eq technique
    end

    it "assigns @note" do
      expect(assigns(:note)).to be_new_record
      expect(assigns(:note).technique).to eq technique
    end

    it "assigns @notes" do
      note = create :note, technique: technique
      another_note = create :note

      get :show, id: technique.id

      expect(assigns(:notes)).to eq [note]
    end

    it { should render_template :show }
  end

  describe "#new" do
    it "assigns @techniqus" do
      sign_in user

      get :new

      expect(assigns(:technique)).to be_new_record
      expect(assigns(:technique).user).to eq user
      expect(subject).to render_template :new
    end

    it "requires authentication" do
      get :index

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#create" do
    context "as a signed in user" do
      before { sign_in user }

      it "creates a new technique" do

        expect do
          post :create, technique: attr
        end.to change { user.techniques.count }

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to Technique.last
      end

      it "doesn't create a new technique if the data is invalid" do
        expect do
          post :create, technique: invalid_attr
        end.not_to change { user.techniques.count }

        expect(subject).to render_template :new
      end
    end

    it "requires authentication" do
      post :create, technique: {}

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#edit" do
    context "as a signed in user" do
      before { sign_in user }

      it "assigns @technique" do
        get :edit, id: technique.id

        expect(assigns(:technique)).to eq technique
        expect(subject).to render_template :edit
      end

      it "doesn't let a user edit other users techniques" do
        get :edit, id: another_technique.id

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      get :edit, id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#update" do
    context "as a signed in user" do
      before { sign_in user }

      it "updates the technique" do
        patch :update, id: technique.id, technique: attr

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to Technique.find(technique.id)
      end

      it "doesn't update the technique if the data is invalid" do
        patch :update, id: technique.id, technique: invalid_attr

        expect(subject).to render_template :edit
      end

      it "doesn't allow users to update other users techniques" do
        patch :update, id: another_technique.id, technique: attr

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      patch :update, id: technique.id, technique: attr

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#delete" do
    context "as a signed in user" do
      before { sign_in user }

      it "destroys the technique" do
        expect do
          delete :destroy, id: technique.id
        end.to change { technique.user.techniques.count }.by -1

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to root_path
      end

      it "doesn't let a user destroy another users techniques" do
        expect do
          delete :destroy, id: another_technique.id
        end.not_to change { technique.user.techniques.count }

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to root_path
      end
    end

    it "requires authentication" do
      delete :destroy, id: technique.id

      expect(subject).to redirect_to new_user_session_path
      expect(subject).to set_the_flash[:alert]
    end
  end
end
