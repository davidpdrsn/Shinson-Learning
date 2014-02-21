require 'spec_helper'

describe "techniques/index" do
  context "there are are techniques" do
    it "shows a list of the techniques" do
      technique = build_stubbed(:technique)
      techniques = {
        "Jokgi Sul" => { "White (mu kup)" => [technique] }
      }
      assign(:techniques, techniques)

      render
      expect(rendered).to match /Jokgi Sul.*White \(mu kup\).*#{technique.name}/m
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