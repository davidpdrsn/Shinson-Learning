require 'spec_helper'

describe "techniques/index" do
  it "shows a list of the techniques" do
    technique = build_stubbed(:technique)
    techniques = {
      "Jokgi Sul" => { "White (mu kup)" => [technique] }
    }
    assign(:techniques, techniques)

    render
    expect(rendered).to match /Jokgi Sul.*White \(mu kup\).*#{technique.name}/m
  end

  it "shows when there are no techniques" do
    assign(:techniques, [])

    with_rendered_page do |page|
      expect(page).to have_content "You have no techniques yet"
    end
  end
end
