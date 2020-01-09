require_relative 'input_reader'
require_relative 'simulation'
require_relative 'moon'

sim = Simulation.new(InputReader.read)
sim.step_n(1000)
puts "Part 1:", sim.total_energy # 12490

x_sim = Simulation.new(InputReader.read, dimension: :x)
y_sim = Simulation.new(InputReader.read, dimension: :y)
z_sim = Simulation.new(InputReader.read, dimension: :z)
puts "Part 2:", [x_sim, y_sim, z_sim].map { |sim| sim.step_until_same; sim.time }.reduce(1, :lcm) # 392733896255168