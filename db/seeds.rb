def create_belts
  [
    ['white', 'mu kup'],
    ['yellow', '9 kup'],
    ['orange', '8 kup'],
    ['green', '7 kup'],
    ['blue', '6 kup'],
    ['blue/red', '5 kup'],
    ['red', '4 kup'],
    ['red/brown', '3 kup'],
    ['brown', '2 kup'],
    ['brown/black', '1 kup'],
    ['black', '1 dan'],
    ['black', '2 dan'],
    ['black', '3 dan'],
    ['black', '4 dan']
  ].each do |belt|
    color = belt.first.titleize
    degree = belt.fetch(1)

    Belt.create(color: color, degree: degree)
  end

  puts "There are now #{Belt.count} belts"
  puts "\n===============\n\n"
end

def create_categories
  [
    "dan jeon hohupbob",
    "gigu sul",
    "hyong",
    "jahse",
    "jokgi sul",
    "kyokpa",
    "miscellaneous",
    "nakbop",
    "pressure point",
    "su",
    "sugi sul",
    "theory",
    "vocabulary",
    "yaksok daeryon",
    "yayo daeryon",
    "yuldong undong"
  ].map(&:titleize).each do |name|
    Category.create(name: name)
  end

  puts "There are now #{Category.count} categories"
  puts "\n===============\n\n"
end

create_belts
rreate_categories
