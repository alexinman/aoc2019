require_relative 'input_reader'
require_relative 'int_code_computer'

memory = InputReader.read_csv.first.map(&:to_i)
cpu = IntCodeComputer.new(memory)
cpu.input = 1
cpu.run
puts "Part 1: ", cpu.output # 2662308295

cpu = IntCodeComputer.new(memory)
cpu.input = 2
cpu.run
puts "Part 2: ", cpu.output # 63441