require 'spec_helper'

feature "deleting techniques" do
  let(:technique) { build :technique }

  scenario "a user deletes a technique" do
    sign_up
    create_technique technique
    click_link "Techniques"
    click_link technique.name
    click_link "Delete"
    click_link "Techniques"

    expect(page).not_to have_content "Ap chagi"
  end
end
