require_relative 'input_reader'
require_relative 'int_code_computer'
require_relative 'hull_painting_robot'

input = InputReader.read_csv.first.map(&:to_i)
robot = HullPaintingRobot.new(input)
robot.run
puts "Part 1:", robot.panels_painted # 2441

robot = HullPaintingRobot.new(input, starting_tile: HullPaintingRobot::WHITE)
robot.run
puts "Part 2:", robot.inspect_painting
 # ███  ████ ███  ████ ███  ███  █  █  ██
 # █  █    █ █  █ █    █  █ █  █ █ █  █  █
 # █  █   █  █  █ ███  █  █ █  █ ██   █
 # ███   █   ███  █    ███  ███  █ █  █
 # █    █    █ █  █    █    █ █  █ █  █  █
 # █    ████ █  █ █    █    █  █ █  █  ██