require 'spec_helper'

describe "techniques/index" do
  context "there are are techniques" do
    it "shows a list of the techniques" do
      technique = build_stubbed(:technique)
      techniques = {
        "jokgi-sul" => { "White (mu kup)" => [technique] }
      }
      assign(:techniques, techniques)

      with_rendered_page do |page|
        expect(page).to have_content technique.name
      end
    end
  end

  context "when there are no techniques" do
    it "shows that there are no techniques" do
      assign(:techniques, [])

      with_rendered_page do |page|
        expect(page).to have_content "You have no techniques yet"
      end
    end
  end
end
