def create_belts
  Belt.destroy_all

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

    if Belt.create(color: color, degree: degree)
      puts "Created #{color}, #{degree}"
    end
  end

  puts "There are now #{Belt.count} belts"
end

create_belts
