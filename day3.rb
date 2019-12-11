require_relative 'input_reader'
require_relative 'helper_methods'

FIRST_WIRE = '1'
SECOND_WIRE = '2'
INTERSECTION = '+'
DELTAS = {
    'R' => [1, 0],
    'L' => [-1, 0],
    'U' => [0, 1],
    'D' => [0, -1]
}
@intersections = {}

def parse_code(code)
  code.split('').partition { |z| z.match?(/\p{Alpha}/) }.map(&:join)
end

def draw_path(grid, code, x, y, marker)
  direction, distance = parse_code(code)
  xd, yd = DELTAS[direction]
  distance.to_i.times do
    x += xd
    y += yd
    grid[x][y] = (grid[x][y] && grid[x][y] != marker) ? INTERSECTION : marker
    @intersections[[x, y]] = 0 if grid[x][y] == INTERSECTION
  end
  return x, y
end

wire1, wire2 = InputReader.read_csv
grid = Hash.new { |h, k| h[k] = {} }
x = y = 0
wire1.each do |code|
  x, y = draw_path(grid, code, x, y, FIRST_WIRE)
end
x = y = 0
wire2.each do |code|
  x, y = draw_path(grid, code, x, y, SECOND_WIRE)
end

x, y = @intersections.keys.min_by { |a, b| manhattan_distance(0, 0, a, b) }
puts "Part 1:", manhattan_distance(0, 0, x, y)

[wire1, wire2].each do |wire|
  length = 0
  x = y = 0
  wire.each do |code|
    direction, distance = parse_code(code)
    xd, yd = DELTAS[direction]
    distance.to_i.times do
      length += 1
      x += xd
      y += yd
      if grid[x][y] == INTERSECTION
        @intersections[[x, y]] += length
      end
    end
  end
end

puts "Part 2:", @intersections.values.min