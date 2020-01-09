require_relative 'input_reader'
require_relative 'simulation'
require_relative 'moon'

sim = Simulation.new(InputReader.read)
sim.step_n(10)
puts "Part 1:", sim.total_energy # 179

sim = Simulation.new(InputReader.read)
sim.step
while sim.original_state != sim.state
  sim.step
end
puts "Part 2:", sim.time