require 'spec_helper'

describe UsersController do
  let(:user) { create :user }
  let(:another_user) { create :user }

  describe "#show" do
    it "assigns @user" do
      get :show, id: user.id

      expect(assigns(:user)).to eq user
    end
  end

  describe "#edit" do
    it "assigns @user" do
      sign_in user

      get :edit, id: user.id

      expect(assigns(:user)).to eq user
    end

    it "doesn't allow the user edit another user" do
      sign_in another_user

      get :edit, id: user.id

      expect(subject).to redirect_to user
      expect(subject).to set_the_flash[:alert]
    end
  end

  describe "#update" do
    let(:attributes) { attributes_for :user }

    context "when user updates himself" do
      before { sign_in user }

      it "updates the user" do
        User.any_instance.stub(:update_attributes).and_return(true)

        patch :update, id: user.id, user: attributes

        expect(subject).to redirect_to user
        expect(subject).to set_the_flash[:notice]
      end

      it "doesn't update the user if the data is invalid" do
        User.any_instance.stub(:update_attributes).and_return(false)
        sign_in another_user

        patch :update, id: user.id, user: attributes

        expect(subject).to redirect_to user
        expect(subject).to set_the_flash[:alert]
      end
    end

    context "when updating another user" do
      it "say NO!" do
        sign_in another_user

        patch :update, id: user.id, user: attributes

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to user
      end
    end
  end

  describe "#destroy" do
    context "when a user deletes himself" do
      it "deletes the user" do
        sign_in user

        expect do
          delete :destroy, id: user.id
        end.to change { User.count }.by -1

        expect(subject).to set_the_flash[:notice]
        expect(subject).to redirect_to root_path
      end
    end

    context "when deleting another user" do
      it "says NO!" do
        sign_in another_user

        delete :destroy, id: user.id

        expect(subject).to set_the_flash[:alert]
        expect(subject).to redirect_to user
      end
    end
  end
end
