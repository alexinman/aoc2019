require_relative 'input_reader'
require_relative 'int_code_computer'
require_relative 'int_code_communicator'

def run_amplifiers(phase_settings)
  communicator = IntCodeCommunicator.new(@memory, phase_settings)
  communicator.run.output
end

@memory = InputReader.read_csv.first.map(&:to_i)
puts "Part 1:", (0..4).to_a.permutation(5).to_a.map(&method(:run_amplifiers)).max # 437860
puts "Part 2:", (5..9).to_a.permutation(5).to_a.map(&method(:run_amplifiers)).max # 49810599
