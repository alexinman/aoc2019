require_relative 'input_reader'

class Planet
  attr_accessor :name, :parent, :children

  def initialize(n)
    self.name = n
    self.children = []
  end

  def add_orbit(planet)
    self.children << planet
    planet.parent = self
  end

  def count_orbits(depth=1)
    children.count*depth + children.map { |c| c.count_orbits(depth+1) }.sum
  end

  def genealogy
    return [] if parent.nil?
    parent.genealogy + [parent.name]
  end
end

planets = Hash.new { |h, k| h[k] = Planet.new(k) }
InputReader.read.map { |o| o.split(')') }.each do |c, o|
  planets[c].add_orbit(planets[o])
end
puts "Part 1:", planets['COM'].count_orbits # 312697

you = planets['YOU'].genealogy
san = planets['SAN'].genealogy
a, b = you.count > san.count ? [you, san] : [san, you]
puts "Part 2:", a.zip(b).reject { |x, y| x == y }.flatten.compact.count # 466