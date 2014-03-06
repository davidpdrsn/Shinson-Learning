require 'spec_helper'

describe "studies/index" do
  before do
    controller.stub(:current_user) { build_stubbed :user }
  end

  context "when there are studies" do
    it "shows that there are studies" do
      study = build_stubbed :study
      assign(:studies, [study])

      with_rendered_page do |page|
        expect(page).to have_link study.pretty_print
      end
    end
  end

  context "when there are no studies" do
    it "shows that there are no studies" do
      assign(:studies, [])

      with_rendered_page do |page|
        expect(page).to have_content "You have no studies"
      end
    end
  end
end
