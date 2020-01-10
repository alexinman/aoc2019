class ArcadePlayer
  attr_accessor :arcade

  def initialize(input)
    self.arcade = ArcadeCabinet.new(input)
  end

  def play
    until arcade.halted?
      arcade.start
      arcade.input = determine_move
      # puts arcade.inspect_screen
    end
  end

  def score
    arcade.score
  end

  private

  def determine_move
    ball_pos = find_ball
    curr_pos = find_position
    ball_pos <=> curr_pos
  end

  def find_ball
    find_tile_id ArcadeCabinet::TILE_IDS[:ball]
  end

  def find_position
    find_tile_id ArcadeCabinet::TILE_IDS[:paddle]
  end

  def find_tile_id(tile_id)
    arcade.screen.each do |x, col|
      col.each do |_y, t_id|
        return x if t_id == tile_id
      end
    end
  end
end