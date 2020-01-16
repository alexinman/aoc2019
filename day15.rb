require_relative 'input_reader'
require_relative 'int_code_computer'
require_relative 'droid'

input = InputReader.read_csv.first.map(&:to_i)
droid = Droid.new(input)
droid.explore
puts "Part 1:", droid.shortest_path_length # 238
puts "Part 2:", droid.fill_oxygen # 392