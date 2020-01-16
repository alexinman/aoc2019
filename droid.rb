class Droid
  COMMANDS = {
      north: 1,
      south: 2,
      west: 3,
      east: 4
  }.freeze

  COORD_CONVERSION = {
      north: [0, -1].freeze,
      south: [0, 1].freeze,
      west: [-1, 0].freeze,
      east: [1, 0].freeze
  }.freeze

  REVERSE_DIR = {
      north: :south,
      south: :north,
      west: :east,
      east: :west
  }.freeze

  REPLIES = {
      wall: 0,
      success: 1,
      oxygen: 2
  }.freeze

  attr_accessor :cpu, :map, :x, :y, :oxygen

  def initialize(input)
    self.cpu = IntCodeComputer.new(input)
    self.map = Hash.new { |h, k| h[k] = {} }
    self.x = 0
    self.y = 0
  end

  def explore
    [:north, :east, :south, :west].each(&method(:explore_direction))
  end

  def shortest_path_length
    q = [[0, 0, 0]]
    until q.empty?
      x, y, dist = q.shift
      case map[x][y]
      when REPLIES[:wall]
        next
      when REPLIES[:success]
        q.push([x, y + 1, dist + 1])
        q.push([x, y - 1, dist + 1])
        q.push([x + 1, y, dist + 1])
        q.push([x - 1, y, dist + 1])
        q.uniq! { |a, b, _| [a, b] }
      when REPLIES[:oxygen]
        return dist
      else
        raise 'what is going on?'
      end
    end
  end

  def fill_oxygen
    q = [
        [oxygen.first, oxygen.last + 1, 1],
        [oxygen.first, oxygen.last - 1, 1],
        [oxygen.first + 1, oxygen.last, 1],
        [oxygen.first - 1, oxygen.last, 1]
    ]
    max = 0
    until q.empty?
      x, y, time = q.shift
      next unless map[x][y] == REPLIES[:success]
      map[x][y] = REPLIES[:oxygen]
      max = [max, time].max
      q.push([x, y + 1, time + 1])
      q.push([x, y - 1, time + 1])
      q.push([x + 1, y, time + 1])
      q.push([x - 1, y, time + 1])
      q.uniq! { |a, b, _| [a, b] }
    end
    max
  end

  def inspect_map
    x_min, x_max = (map.keys + [self.x]).minmax
    y_min, y_max = (map.values.map(&:keys).flatten + [self.y]).minmax
    (y_min..y_max).map do |y|
      (x_min..x_max).map do |x|
        next 's' if x == 0 && y == 0
        case map[x][y]
        when REPLIES[:wall]
          '#'
        when REPLIES[:success]
          ' '
        when REPLIES[:oxygen]
          'o'
        else
          '█'
        end
      end.join('')
    end.join("\n")
  end

  private

  attr_writer :output

  def explore_direction(dir)
    self.x += COORD_CONVERSION[dir].first
    self.y += COORD_CONVERSION[dir].last

    if map[x][y].nil?
      move_droid(dir)
      output = cpu.output
      map[x][y] = output
      if output == REPLIES[:success] || output == REPLIES[:oxygen]
        explore
        move_droid(REVERSE_DIR[dir])
        self.oxygen = [x, y] if output == REPLIES[:oxygen]
      end
    end

    self.x -= COORD_CONVERSION[dir].first
    self.y -= COORD_CONVERSION[dir].last
  end

  def move_droid(dir)
    cpu.input = COMMANDS[dir]
    cpu.run
  end
end