require 'spec_helper'

feature 'viewing techniques' do
  let(:technique) { build :technique }
  before { sign_up }

  scenario "a user views his list of techniques using another grouping", js: true do
    technique = build :technique,
      name: "Ap chagi",
      description: "description",
      belt: create(:belt, color: "white", degree: "mu kup"),
      category: create(:category, name: "Jokgi sul")

    create_technique technique
    click_link "Techniques"
    select 'Belt then category', from: 'groupings'

    expect(page.body).to match /White \(mu kup\).*Jokgi Sul.*Ap chagi/mi
  end

  scenario "A user sees that the list is sorted" do
    create_technique build :technique, name: "Gibon sul 10"
    create_technique build :technique, name: "Gibon sul 2"
    create_technique build :technique, name: "Gibon sul 1"
    click_link "Techniques"

    expect(page.body).to match /Gibon sul 1.*Gibon sul 2.*Gibon sul 10/mi
  end

  scenario 'a user views a single technique' do
    create_technique technique
    visit root_path
    click_link "Techniques"
    click_link technique.name

    expect(page).to have_content technique.name
  end
end
