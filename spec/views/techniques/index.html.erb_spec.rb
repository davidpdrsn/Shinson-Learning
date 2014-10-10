require 'spec_helper'

describe "techniques/index" do
  before do
    controller.stub(:current_user).and_return(build_stubbed(:user))
  end

  context "when there are techniques" do
    let(:technique) { build_stubbed(:technique) }
    let(:techniques) do
      { "Jokgi Sul" => { "White (mu kup)" => [technique] } }
    end
    before do
      page = TechniquesIndexPage.new(techniques: techniques, default_grouping: nil)
      assign(:page, page)
    end

    it "shows a list of the techniques" do
      render
      expect(rendered).to match /Jokgi Sul.*White \(mu kup\).*#{technique.name}/m
    end

    it "shows groupings select" do
      with_rendered_page do |page|
        expect(page).to have_css "select"
      end
    end

    context "when there are also notes" do
      it "shows the note count when a technique has notes" do
        technique.stub(:notes_count) { 2 }

        with_rendered_page do |page|
          expect(page).to have_content "(2 notes)"
        end
      end
    end
  end

  context "when there are no techniques" do
    before { assign(:page, TechniquesIndexPage.new(techniques: [], default_grouping: nil)) }

    it "shows when there are no techniques" do
      with_rendered_page do |page|
        expect(page).to have_content "You have no techniques yet"
      end
    end

    it "doesn't show groupings select when there are no techniques" do
      with_rendered_page do |page|
        expect(page).not_to have_css "select"
      end
    end
  end
end
