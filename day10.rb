require_relative 'input_reader'

EMPTY = '.'
ASTEROID = '#'

input = InputReader.read.map { |i| i.split('') }
asteroids = []
input.each_with_index do |row, y|
  row.each_with_index do |pos, x|
    asteroids << [x.to_f, y.to_f] if pos == ASTEROID
  end
end

def get_angle(x1, y1, x2, y2)
  x = x2 - x1
  y = y2 - y1
  a = Math.atan2(x, -y)
  a += Math::PI * 2 if a < 0
  a
end

max, asteroids = asteroids.map do |x, y|
  angles = (asteroids - [[x, y]]).map do |a, b|
    dist = Math.sqrt((a - x) ** 2 + (b - y) ** 2)
    [a, b, get_angle(x, y, a, b), dist]
  end
  [angles.uniq { |_, _, angle, _dist| angle }.count, angles]
end.max_by { |count, _asteroids| count }

puts "Part 1: ", max # 269

asteroids.group_by { |_x, _y, angle, _dist| angle }.each do |_, group|
  group.sort_by { |_x, _y, _angle, dist| dist }.each_with_index do |asteroid, index|
    asteroid[2] += index * Math::PI * 2
  end
end

x, y = asteroids.sort_by { |_x, _y, angle| angle }[199]
puts "Part 2: ", (x * 100 + y).to_i # 612