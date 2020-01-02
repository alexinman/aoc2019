require_relative 'input_reader'
require_relative 'int_code_computer'

input = InputReader.read_csv.first.map(&:to_i)
input[1] = 12
input[2] = 2
computer = IntCodeComputer.new(input).run
puts "Part 1:", computer[0] # 3716293

noun = nil
verb = nil
(0..99).each do |n|
  (0..99).each do |v|
    input[1] = n
    input[2] = v
    next unless IntCodeComputer.new(input).run[0] == 19690720
    noun = n
    verb = v
  end
end
puts "Part 2:", 100 * noun + verb # 6429