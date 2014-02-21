require 'spec_helper'

describe "techniques/show" do
  it "shows links to edit and destroy the technique if the user owns it" do
    user = build_stubbed(:user)
    technique = build_stubbed(:technique, user: user)
    controller.stub(:current_user).and_return(user)
    assign(:technique, technique)

    with_rendered_page do |page|
      expect(page).to have_content "Edit"
      expect(page).to have_content "Delete"
    end
  end

  it "doesn't shows links to edit and destroy the technique if the user doesn't own it" do
    user = build_stubbed(:user)
    technique = build_stubbed(:technique)
    controller.stub(:current_user).and_return(user)
    assign(:technique, technique)

    with_rendered_page do |page|
      expect(page).not_to have_content "Edit"
      expect(page).not_to have_content "Delete"
    end
  end
end
