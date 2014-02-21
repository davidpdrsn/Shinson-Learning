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

def create_techniques
  Technique.destroy_all

  black  = Belt.where(degree: "1 dan").first
  yellow = Belt.where(color: "Yellow").first
  white  = Belt.where(color: "White").first
  su     = Category.where(name: "Su").first
  kicks  = Category.where(name: "Jokgi Sul").first
  me     = User.where(email: "david.pdrsn@gmail.com").first

  {
    "arrero" => [
      "Blokering højt, skridt frem, albue lås",
      "Skulderkast",
      "Ud på siden, kniv i lår, yok sudo på hals",
      "Yop chagi til albue",
      "Sudo på hals"
    ],
    "paroh" => [
      "Gibon sul 4",
      "Sujang bangosul, sudo på underarm, slag på hals, ben fejning, gong gong",
      "Baby",
      "Håndledslås, (spark i mave), flyver med ben, skulderlås",
      "Flyver"
    ],
    "annuro" => [
      "Dobbelt sudo, albue i hovedet, ben fejning",
      "Albuelås, murub chagi, hoftekast",
      "Jackie Chan",
      "Slyng",
      "Nervepunkt ved krageben, trykke i gulvet"
    ],
    "bagguro" => [
      "Gibon sul 5",
      "Sujang sangdan, yok sudo under arm,  halslås klæbe",
      "Jung jie maedup kwon til ribben",
      "Albuelås over brystet",
      "Træk ved skuldre skub i knæhase"
    ]
  }.each do |group, techniques|
    techniques.each.with_index do |description, n|
      Technique.create(
        name: "Kal makki #{group} ##{n+1}",
        description: description,
        belt: black,
        category: su,
        user: me
      )
    end
  end

  [
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know...",
    "You know..."
  ].each.with_index do |description, n|
    Technique.create(
      name: "Gibon Sul ##{n+1}",
      description: description,
      belt: yellow,
      category: su,
      user: me
    )
  end

  [
    "Ap chagi",
    "Dollyo chagi",
    "Murub chagi",
    "Andari chagi",
    "Ap chaoligi"
  ].each do |kick|
    Technique.create(
      name: kick,
      description: "You know...",
      belt: white,
      category: kicks,
      user: me
    )
  end

  [
    "Yop chagi",
    "Dwidgumchi dollyo chagi",
    "Dwidgumchi chaoligi",
    "Balbadak dollyo chagi",
    "Dwid chagi",
    "Dwidgumchi dwid chaoligi"
  ].each do |kick|
    Technique.create(
      name: kick,
      description: "You know...",
      belt: yellow,
      category: kicks,
      user: me
    )
  end
end

create_belts
create_categories
create_techniques
