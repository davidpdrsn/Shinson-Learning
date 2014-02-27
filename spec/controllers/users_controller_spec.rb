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
end
