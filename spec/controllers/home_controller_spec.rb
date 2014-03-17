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

      it "assigns @neglected_studies" do
        study = double :study
        Study.stub(:neglected_for_user).with(user).and_return([study])

        get :index

        expect(Study).to have_received(:neglected_for_user).with(user)
        expect(assigns(:neglected_studies)).to eq [study]
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
