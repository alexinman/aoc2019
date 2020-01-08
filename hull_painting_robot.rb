class HullPaintingRobot
  BLACK = 0
  WHITE = 1

  TURN_LEFT = 0
  TURN_RIGHT = 1

  DIRECTIONS = {
      up: [0, 1],
      down: [0, -1],
      right: [1, 0],
      left: [-1, 0]
  }.freeze

  def initialize(input, starting_tile: BLACK)
    self.cpu = IntCodeComputer.new(input, wait_on_output: true)
    self.grid = Hash.new { |h, k| h[k] = Hash.new(0) }
    self.x = 0
    self.y = 0
    grid[x][y] = starting_tile
    self.direction = :up
  end

  def run
    cpu.run
    until cpu.halted?
      cpu.input = grid[x][y]
      cpu.run
      paint(cpu.output)
      cpu.run
      turn(cpu.output)
      move
      cpu.run
    end
  end

  def panels_painted
    grid.values.map(&:values).flatten.count
  end

  def inspect_painting
    xmin, xmax = grid.keys.minmax
    ymin, ymax = grid.values.map(&:keys).flatten.minmax
    (ymin..ymax).reverse_each.map do |y|
      (xmin..xmax).map do |x|
        grid[x][y] == BLACK ? ' ' : '█'
      end.join('')
    end.join("\n")
  end

  private

  def paint(code)
    grid[x][y] = code
  end

  def turn(code)
    self.direction = case direction
                     when :up
                       code == TURN_LEFT ? :left : :right
                     when :down
                       code == TURN_LEFT ? :right : :left
                     when :left
                       code == TURN_LEFT ? :down : :up
                     when :right
                       code == TURN_LEFT ? :up : :down
                     else
                       raise
                     end
  end

  def move
    self.x = x + DIRECTIONS[direction].first
    self.y = y + DIRECTIONS[direction].last
  end

  attr_accessor :cpu, :x, :y, :direction, :grid
end