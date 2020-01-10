class ArcadeCabinet
  attr_accessor :screen

  TILE_IDS = {
      empty: 0,
      wall: 1,
      block: 2,
      paddle: 3,
      ball: 4
  }.freeze

  def initialize(input)
    self.cpu = IntCodeComputer.new(input, wait_on_output: true)
    self.screen = Hash.new { |h, k| h[k] = {} }
  end

  def start
    until cpu.halted? || cpu.waiting_on_input?
      cpu.run
      read_output
    end
  end

  def read_output
    output = cpu.output
    return if output.nil?
    @outputs ||= []
    @outputs << output
    if @outputs.length == 3
      x, y, tile_id = @outputs
      @outputs = nil
      screen[x][y] = tile_id
    end
  end

  def halted?
    cpu.halted?
  end

  def input=(i)
    cpu.input = i
  end

  def score
    screen[-1][0]
  end

  def inspect_screen
    x_min, x_max = screen.keys.minmax
    y_min, y_max = screen.values.map(&:keys).flatten.minmax
    (y_min..y_max).map do |y|
      (x_min..x_max).map do |x|
        case screen[x][y]
        when TILE_IDS[:empty]
          ' '
        when TILE_IDS[:wall]
          '█'
        when TILE_IDS[:block]
          '#'
        when TILE_IDS[:paddle]
          '-'
        when TILE_IDS[:ball]
          '•'
        else
          ' '
        end
      end.join('')
    end.join("\n") + "\n Score: #{score}\n"
  end

  private

  attr_accessor :cpu
end