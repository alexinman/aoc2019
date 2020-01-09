class Moon
  attr_accessor :position, :velocity

  def initialize(i)
    _, x, y, z = /<x=(-?\d+), y=(-?\d+), z=(-?\d+)>/.match(i).to_a.map(&:to_i)
    self.position = {x: x, y: y, z: z}
    self.velocity = {x: 0, y: 0, z: 0}
  end

  def total_energy
    potential_energy * kinetic_energy
  end

  def potential_energy
    position.values.map(&:abs).sum
  end

  def kinetic_energy
    velocity.values.map(&:abs).sum
  end

  def apply_gravity(moon, dimensions)
    dimensions.each { |dimension| apply_dimension_gravity(moon, dimension) }
  end

  def apply_dimension_gravity(moon, dimension)
    velocity[dimension] += axis_gravity(position[dimension], moon.position[dimension])
  end

  def apply_velocity(dimensions)
    dimensions.each(&method(:apply_dimension_velocity))
  end

  def apply_dimension_velocity(dimensions)
    position[dimensions] += velocity[dimensions]
  end

  private

  def axis_gravity(one, two)
    two <=> one
  end
end