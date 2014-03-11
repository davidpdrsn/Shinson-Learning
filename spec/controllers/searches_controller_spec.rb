require 'spec_helper'

describe SearchesController do
  describe "#create" do
    context "as a signed in user" do
      let(:user) { create :user }
      before { sign_in user }

      it "searches for techniques" do
        technique = create :technique, user: user, name: "foo"
        post :create, query: "Foo", format: :json

        json = JSON.parse response.body
        expect(json.first.fetch "id").to eq technique.id
      end

      it "does a fuzzy search" do
        technique = create :technique, user: user, name: "bar"
        post :create, query: "br", format: :json

        json = JSON.parse response.body
        expect(json.first.fetch "id").to eq technique.id
      end

      it "doesn't find techniques that belong to other users" do
        technique = create :technique, user: user, name: "foo"
        another_technique = create :technique, name: "foo"
        post :create, query: "foo", format: :json

        json = JSON.parse response.body
        expect(json.first.fetch "id").to eq technique.id
        expect(json.length).to eq 1
      end
    end

    it "requires authentication" do
      post :create

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
