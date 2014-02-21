def create_technique(name="Ap chagi",
                     description="foo",
                     belt="White (mu kup)",
                     category="Jokgi sul")

  unless Category.find_by(name: category)
    create(:category, name: category)
  end

  unless Belt.all.map.any? { |b| b.pretty_print == belt }
    match = belt.match(/(?<color>.*?) \((?<degree>.*?)\)/)
    Belt.create(color: match[:color], degree: match[:degree])
  end

  visit root_path
  click_link "New technique"
  fill_in "Name", with: name
  fill_in "Description", with: description
  select belt, from: "Belt"
  select category, from: "Category"
  click_button "Create Technique"
end
