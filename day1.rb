require_relative 'input_reader'

def fuel_required(mass)
  (mass / 3) - 2
end

input = InputReader.read.map(&:to_i)
puts "Part 1:", input.map(&method(:fuel_required)).sum # 3239503

def fuel_required_v2(mass)
  total_fuel = 0
  fuel = fuel_required(mass)
  while fuel > 0
    total_fuel += fuel
    fuel = fuel_required(fuel)
  end
  total_fuel
end

puts "Part 2:", input.map(&method(:fuel_required_v2)).sum # 4856390