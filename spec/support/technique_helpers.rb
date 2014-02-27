def create_technique technique = build(:technique)
  visit root_path
  click_link "New technique"
  fill_in "Name", with: technique.name
  fill_in "Description", with: technique.description
  select technique.belt.pretty_print, from: "Belt"
  select technique.category.name, from: "Category"
  click_button "Create Technique"
end
