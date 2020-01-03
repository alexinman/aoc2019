require_relative 'input_reader'

WIDTH = 25
HEIGHT = 6

BLACK = 0
WHITE = 1
TRANSPARENT = 2

input = InputReader.read.first.split('').map(&:to_i)
layers = input.each_slice(WIDTH * HEIGHT)
least_zeroes = layers.min_by { |layer| layer.count(0) }
puts "Part 1: ", least_zeroes.count(1) * least_zeroes.count(2) # 1703

image = Array.new(WIDTH) { Array.new(HEIGHT) }
layers.reverse_each do |layer|
  layer.each_slice(WIDTH).each_with_index do |row, y|
    row.each_with_index do |pixel, x|
      image[x][y] = case pixel
                    when BLACK
                      ' '
                    when WHITE
                      '█'
                    else
                      next
                    end
    end
  end
end
puts "Part 2: ", image.transpose.map { |row| row.map(&:to_s).join }.join("\n")
# █  █  ██   ██  ████ ████
# █  █ █  █ █  █ █    █
# ████ █    █    ███  ███
# █  █ █    █ ██ █    █
# █  █ █  █ █  █ █    █
# █  █  ██   ███ █    ████