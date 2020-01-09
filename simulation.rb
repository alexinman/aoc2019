class Simulation
  attr_accessor :moons, :time, :dimensions

  def initialize(input, dimension:nil)
    self.moons = input.map { |i| Moon.new(i) }
    self.time = 0
    self.dimensions = dimension.nil? ? [:x, :y, :z] : [dimension]
  end

  def step_n(n)
    n.times { step }
  end

  def step_until_same
    original_state = moons.inspect
    step
    until original_state == moons.inspect
      step
    end
  end

  def step
    apply_gravity
    apply_velocity
    self.time = time + 1
  end

  def total_energy
    moons.map(&:total_energy).sum
  end

  private

  def apply_gravity
    moons.permutation(2) do |m1, m2|
      m1.apply_gravity(m2, dimensions)
    end
  end

  def apply_velocity
    moons.each { |moon| moon.apply_velocity(dimensions) }
  end
end