require 'spec_helper'

describe "questions/index" do
  let(:question) { build_stubbed(:question) }

  before do
    view.stub(:current_user).and_return(build_stubbed(:user))
    view.stub(:timestamp)
  end

  context "when there are questions" do
    it "shows a list of questions" do
      assign(:questions, [question])

      with_rendered_page do |page|
        expect(page).to have_content question.text
      end
    end
  end

  context "when there are no questions" do
    it "shows when there are no questions" do
      assign(:questions, [])

      with_rendered_page do |page|
        expect(page).to have_content "You have no notes marked as questions"
      end
    end
  end
end
