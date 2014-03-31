require 'spec_helper'

describe HomeController do
  describe "#index" do
    context "as a signed in user" do
      let(:user) { create :user }
      before { sign_in user }

      it "renders the signed in template" do
        get :index

        expect(controller).to render_template :signed_in
      end
    end

    context "as a guest" do
      it "renders the landing page" do
        get :index

        expect(controller).to render_template :index
      end
    end
  end
end
