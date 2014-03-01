File.read("perf/stats.csv").lines.each do |line|
  match = line.match /(?<rev>.*?),(?<time>.*)/
  print match[:rev] + " "
  puts "#" * (match[:time].to_f * 1000) + " #{match[:time]}"
end
