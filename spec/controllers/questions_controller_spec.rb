require 'spec_helper'

describe QuestionsController, "GET #index" do
  context "as a signed in user" do
    it "assigns @questions to be the users questions" do
      user = create(:user)
      sign_in user
      question = create(:question, user: user)
      user.stub(:questions).and_return([question])

      get :index

      expect(assigns(:questions)).to eq [question]
    end
  end

  it "requires authentication" do
    get :index

    expect(subject).to redirect_to new_user_session_path
    expect(subject).to set_the_flash[:alert]
  end
end
