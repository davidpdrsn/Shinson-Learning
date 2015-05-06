require "spec_helper"

feature "searching" do
  scenario "for techniques" do
    user = create :user
    sign_in(user)
    technique = create :technique, user: user
    visit root_path
    fill_in "search", with: technique.name
    click_button "Search"

    expect(page).to have_content "Results for \"#{technique.name}\""
    expect(page).to have_css "a", text: technique.name
  end
end
