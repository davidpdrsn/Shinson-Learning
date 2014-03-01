require 'benchmark'

def benchmark &block
  block.call
  iterations = 100
  time = (1..iterations).inject([]) do |acc|
    acc << Benchmark.realtime { block.call }
  end.inject(:+)./(iterations).round 5
  puts "RUNTIME: #{time}"
end
