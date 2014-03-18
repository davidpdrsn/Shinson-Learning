class AddsWhiteTechniques
  def initialize user
    @user = user
  end

  def add_techniques
    add_su

    {
      hohupbob => {
        "Gibon danjeon hohupbob #1" => "Skubbe jorden fremad",
        "Gibon danjeon hohupbob #2" => "Løfte himlen til jorden",
        "Gibon danjeon hohupbob #3" => "Omfavne jorden",
        "Gibon danjeon hohupbob #4" => "Trække himlen til jorden",
      },
      yuldong_undong => {
        "Yuldong Undong #1" => "Steppe",
        "Yuldong Undong #2" => "Frem og tilbage",
        "Yuldong Undong #3" => "Side til side",
        "Yuldong Undong #4" => "Side til side med kryds",
        "Yuldong Undong #5" => "Fri rytme",
      },
      jahse => {
        "Charyot jahse" => "Hilsestand",
        "Moa jahse" => "Lukket hilsestand",
        "Bango jahse" => "Forsvarsstand",
        "Gongkyok jahse" => "Angrebsstand",
        "Gima pyong jahse" => "Dyb flad stand",
        "Gibon pyong jahse" => "Flad grundstilling",
      },
      sugi_sul => {
        "Sujang bango sul" => "Forsvarsteknik med håndfladen",
        "Samagui bango sul" => "Forsvarsteknik i knælerstilling",
        "Sudo bango sul" => "Forsvarsteknik med håndkanten",
        "Yok-sudo bango sul" => "Forsvarsteknik med indersiden af håndkanten",

        "Sujang gongkyok sul" => "Angrebsteknik med håndfladen",
        "Samagui gongkyok sul" => "Angrebsteknik med håndryggen",
        "Sudo gongkyok sul" => "Angrebsteknik med håndkanten",
        "Yok-sudo gongkyok sul" => "Angrebsteknik med indersiden af håndkanten",

        "Palgumchi uiro chigi" => "Albuespidsstik opad",
        "Palgumchi araero chigi" => "Albuespidsstik nedad",
        "Palgumchi yoppuro chigi" => "Albuespidsstik udad",
        "Palgumchi annuro chigi" => "Albuespidsstik indad",
      },
      nakbop => {
        "Jon bang nakbop" => "Forlæns faldteknik",
        "Hu bang nakbop" => "Baglæns faldteknik",
        "Chuk bang nakbop" => "Sidelæns faldteknik",
        "Hoe jon nakbop" => "Forlæns rulleteknik",
      },
      kicks => {
        "Ap chagi" => "Fodballespark fremad",
        "Murub chagi" => "Knæstød",
        "Dollyo chagi" => "Halvcirkelspark indefter",
        "Andari chagi" => "Cirkelspark udefra og ind",
        "Ap cha olligi" => "Fodballespark lige nedefra og op fremad",
      },
    }.each do |category, techniques|
      create_techniques_in_category category, techniques
    end
  end

  private

  def create_techniques_in_category category, techniques
    techniques.each do |name, description|
      unless user_has_technique name
        Technique.create! user: @user,
                          category: category,
                          belt: white,
                          name: name,
                          description: description
      end
    end
  end

  def add_su
    {
      "Son baegi sul" => [
        "Håndfladeskubbeteknik",
        "Albuestød nedefra ogopad",
        "Langt armkast med forlænsdrejning",
      ],
      "Ott baegi sul" => [
        "Håndkantsslag på håndled og håndrygslag til tinding",
        "Håndkantsslag på håndled og albuestød til solaplexus",
        "Langt armkast med baglænsdrejning",
      ],
    }.each do |name, techniques|
        techniques.each.with_index do |description, i|
          full_name = "#{name} ##{i+1}"

          unless user_has_technique full_name
            Technique.create! user: @user,
                              category: su,
                              belt: white,
                              name: full_name,
                              description: description
          end
        end
      end
  end

  def user_has_technique name
    Technique.where(user: @user).find_by(name: name).present?
  end

  def theory
    Category.find_by name: "Theory"
  end

  def yuldong_undong
    Category.find_by name: "Yuldong Undong"
  end

  def jahse
    Category.find_by name: "Jahse"
  end

  def sugi_sul
    Category.find_by name: "Sugi Sul"
  end

  def hohupbob
    Category.find_by name: "Dan Jeon Hohupbob"
  end

  def nakbop
    Category.find_by name: "Nakbop"
  end

  def su
    Category.find_by name: "Su"
  end

  def kicks
    Category.find_by name: "Jokgi Sul"
  end

  def white
    Belt.find_by color: "White"
  end
end
