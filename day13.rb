require_relative 'input_reader'
require_relative 'int_code_computer'
require_relative 'arcade_cabinet'
require_relative 'arcade_player'

input = InputReader.read_csv.first.map(&:to_i)
ac = ArcadeCabinet.new(input)
ac.start
puts "Part 1:", ac.screen.values.map(&:values).flatten.count(ArcadeCabinet::TILE_IDS[:block]) # 226

input[0] = 2
ap = ArcadePlayer.new(input)
ap.play
puts "Part 2:", ap.score # 10800