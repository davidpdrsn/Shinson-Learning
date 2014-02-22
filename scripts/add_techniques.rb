black = Belt.where(degree: "1 dan").first
me    = User.where(email: "david.pdrsn@gmail.com").first
su    = Category.where(name: "Su").first
kicks = Category.where(name: "Jokgi Sul").first
weapons = Category.where(name: "Gigu Sul").first
punches = Category.where(name: "Sugi Sul").first
misc = Category.where(name: "Miscellaneous").first
yaksok = Category.where(name: "Yaksok Daeryon").first
hyong = Category.where(name: "Hyong").first

# me.techniques.destroy_all

techniques = Hash.new

techniques[kicks] = {
  "Balgud saeo jierigi" => "Stik med spidsen af tæerne, lodret",
  "Balgud jierigi" => "Stik med tåspidsen.",
  "Angumchi bagguro chadolligi" => "Spark med indersiden af hælen indefra og udaf",
  "Balnal annuro chadolligi" => "Spark med fodkanten indad",
  "Balnal chaoligi" => "Snit spark med kanten af foden.",
  "Kyongol hyrryo chagi" => "Skindebensspark, possibly out of date",
  "Dwingumchi chaangi" => "Kroge spark med hælen, måske out dated",
  "An gumchi chanogi" => "...",
  "Bal dung pyrryo chagi" => "Fodboldspark, kun maaske"
}

techniques[hyong] = {
  "Dan bong hyong" => "..."
}

techniques[punches] = {
  "Ho kwon" => "Tiger slag, slag med håndflade siden af knytnæve",
  "Manji kwon" => "Hammer slag",
  "Sae kwon" => "Lille krog",
  "Purri kwon" => "Fugle ting"
}

techniques[misc] = {
  "Sugi jok sul" => [
    "Andari chagi - annuro samagui - dora sudo chigi",
    "Dung kwon - hahdan sujang chapgi - dora chuk son daerigi - baldung yop chagi",
    "Sujang nullu makki gima pyong jahse - jung jie maedup kwon - yop chagi - yop chagi",
    "Sam bang tta - sudo gama chigi gima pyong jahse - sudo gaanaerigi",
    "Yok sudo - sangdan dora chagi - hadan dora chagi"
  ]
}

techniques[yaksok] = {
  "Dan bong yaksok daeryon" => [
    "Slag lige frem: blokering direkt, direkte slag ca med håndryggen.",
    "Slag lige frem: blokering med bong ud af. Slag til dae maeg",
    "Cirkel slag ind af: direkte blokering på, slag tending",
    "Cirkel slag ud af: blokering ud af, slag med anden ende til hah guan",
    "Stik: cirkel blokering stik",
    "Stik: yderside, slag knæhase",
    "Ap chagi: cirkel blokering knæ, cirkel slag til tending",
    "Ap chagi: direkte blokering og slag",
    "Ap chagi: direkte blokering stik, stik bagside under hage",
    "Ap chagi: under knæhase, ban pyong løft under hage",
    "Ap chagi: inderside, stik ki sae",
    "Ap chagi: yderside, stik ki sae, hop stik amun"
  ],
  "Chang bong yaksok daeryon" => [
    "Baek hoe chigi - ourrio ollyo makki, slag til tae yang",
    "Baek hoe chigi - ourrio ollyo makki, slag til tae yang, slag til skridtet",
    "Mok dollyo chigi - Jungdan saeowa makki, stik til yom chon",
    "Mok dollyo chigi - Jungdan saeowa makki, stik til yom chon, skub i knæhase",
    "Jungdan Jierigi - Jungdan saeowa makki, slag til nakke",
    "Jungdan Jierigi - Jungdan saeowa makki, slag til nakke, stik i fod",
    "Slag stråt oppe fra - Makki stråt oppe fra, skub til hals",
    "Slag stråt oppe fra - Makki stråt oppe fra, skub til hals, hop drej slag til tae yang",
    "Slag efter skidtet/lavt - Makki lavt, slag med hver ende til tae yang",
    "Slag efter skidtet/lavt - Makki lavt, slag med hver ende til tae yang, stik til yom chon, hop drej slag til tae yang",
    "Cirkulært slag lavt - Et bens blokering, fat i anden ende slag imod ben",
    "Cirkulært slag lavt - Et bens blokering, fat i anden ende slag imod ben, slag i mod hoved",
  ]
}

techniques[weapons] = {
  "Dan bong bangosul" => [
    "Direct up",
    "Direct up hand turned",
    "Inside",
    "Outside",
    "Low annuro",
    "Low bagguro",
    "Sideways body moves right",
    "Sideways body moves left",
    "Double",
    "Ban pyong down"
  ],
  "Dan bong gong kyok sul" => [
    "direct",
    "annuro circle",
    "bagguro circle",
    "stab",
    "punch with other end",
    "stab ki sal",
    "punch other end ",
    "low annuro",
    "low bagguro",
    "back hand",
  ],
  "Chang bong dollyogi appuro" => [
    "Håndledsgymnastik",
    "360 drej foran",
    "Som 2, men i bevægelse",
    "Bong og jeg drejer 180, begge veje, lille og tommel",
    "Bong bliver, jeg drejer",
    "Under benet",
    "Med kast",
  ],
  "Chang bong dollyogi yoppuro" => [
    "Chayot",
    "2 hænder, ro kajak",
    "Fra side til side med skift",
    "En hånd side til side uden skift",
    "1 hånd side til side op i armhulen",
    "På ryggen og tilbage med 1 hånd",
    "Jeg bliver bong drejer 360 rundt om mig",
  ],
  "Chang bong dollyogi ourrio" => [
    "Håndledsgymnastik",
    "360 drej over hovedet",
    "Ned og sidde",
    "Ned og ligge",
    "Rulle",
    "Op og stå, hop ned og sidde",
    "På ryggen med hop, eller på stedet",
  ]
}

techniques[su] = {
  "Kal makki arrero" => [
    "Blokering højt, skridt frem, albue lås",
    "Skulderkast",
    "Ud på siden, kniv i lår, yok sudo på hals",
    "Yop chagi til albue",
    "Sudo på hals"
  ],
  "Kal makki paroh" => [
    "Gibon sul 4",
    "Sujang bangosul, sudo på underarm, slag på hals, ben fejning, gong gong",
    "Baby",
    "Håndledslås, (spark i mave), flyver med ben, skulderlås",
    "Flyver"
  ],
  "Kal makki annuro" => [
    "Dobbelt sudo, albue i hovedet, ben fejning",
    "Albuelås, murub chagi, hoftekast",
    "Jackie Chan",
    "Slyng",
    "Nervepunkt ved krageben, trykke i gulvet"
  ],
  "Kal makki bagguro" => [
    "Gibon sul 5",
    "Sujang sangdan, yok sudo under arm,  halslås klæbe",
    "Jung jie maedup kwon til ribben",
    "Albuelås over brystet",
    "Træk ved skuldre skub i knæhase"
  ],
  "Gibon hwalyoung sul" => [
    "...",
    "...",
    "En direkte cirkel, yderside",
    "...",
    "...",
    "Inderside af ben, yderside af arm",
    "Ikke nødtvendigvis med ben, yoksudo til hals",
    "Gå igennem",
    "Mellem ben og arm, forsætte fremad",
    "Cirkel",
    "Inderside",
    "Fat ved skulder, slag til mave",
    "...",
    "...",
    "Inderside"
  ],
  "Jiabb sul" => [
    "I hår – su sam ri",
    "I hår – ki sal + kyol bun",
    "I nakken – hah guon",
    "Om livet – yee pung",
    "Forsøg på greb om armene – om jie kwon til guk chon",
    "I bæltet oppefra – gock jie",
    "I bæltet nedefra – so hae",
    "Forsøg på kvæler – hweng glo",
    "Samme start – lunge 7,8,9",
    "I håndled – verdens fedeste med hap gock"
  ],
  "Han son mock sul" => [
    "Verdens fedeste chok - tryk på su sam ri",
    "Verdens fedeste chok - træk i dobok",
    "Verdens fedeste chok - træk i underarm",
    "Håndflade op dreje lås - gong jeong på stedet",
    "Håndflade op dreje lås - yok sudo",
    "Håndflade op dreje lås - træk i albue",
    "Verdens fedeste - træk i hånd",
    "Kaffemølle",
    "Verdens fedeste - træk i hånd spark over knæ",
    "Verdens fedeste - sudo til siden"
  ],
  "Chao waggi" => [
    "sidde ned, fat i hår, japaner",
    "fat i krave, sam um gio",
    "fat i krave, albue på knæ",
    "fat i krave, kaffemølle",
    "jiggo chagi på hwengol",
    "ligge ned på siden med albue under hovedet, saks",
    "kroge yop chagi",
    "skup med skindeben",
    "squat kvæler, balance skub",
    "krydskvæler, halsvrider",
    "kvæler, gibon sul 5",
    "kvæler tæt, guk chon",
    "slag, gibon sul 5",
    "slag, gibon sul 5+6",
    "kvæler fra siden, chong myong"
  ],
  "Ban toogi sul" => [
    "Sudo på albue, palgup til gumi",
    "Sudo til albue så til hals",
    "Sudo til hals, arm bagud rundt og op, murub i mave",
    "Baby",
    "Flyver",
    "Elefant",
    "Gibon sul 5 til 6",
    "Hoftekast, med noget albuelås og murub chagi",
    "Fat om nakke, albue på mave, gong jeong over ben",
    "Skubbe på hage, benfeje"
  ]
}

techniques.each do |category, techniques_in_category|
  techniques_in_category.each do |group, techniques_in_group|
    if techniques_in_group.is_a?(Array)
      techniques_in_group.each.with_index do |description, n|
        Technique.create(
          name: "#{group} ##{n+1}",
          description: description,
          belt: black,
          category: category,
          user: me
        )
      end
    else
      Technique.create(
        name: group,
        description: techniques_in_group,
        belt: black,
        category: category,
        user: me
      )
    end
  end
end
