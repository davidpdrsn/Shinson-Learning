require 'spec_helper'

describe "questions/index" do
  let(:question) { build_stubbed(:question) }

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