require 'spec_helper'

describe ScoresController do
  describe "#create" do
    context "as a signed in user" do
      let(:study) { create :study }
      let(:user) { study.user }
      before { sign_in user }

      it "creates the score" do
        Score.any_instance.stub(:valid?) { true }

        expect do
          post :create,
               study_id: study.id,
               score: { correct_answers: 1 },
               format: :json
        end.to change { study.scores.count }

        expect(response.status).to be 200
      end

      it "doesn't create it if its not valid" do
        Score.any_instance.stub(:valid?) { false }

        expect do
          post :create,
               study_id: study.id,
               score: { correct_answers: nil },
               format: :json
        end.not_to change { study.scores.count }

        expect(response.status).to be 422
      end
    end

    it "requires authentication" do
      post :create, study_id: 1, score: {}

      expect(subject).to redirect_to new_user_session_path
    end
  end
end
