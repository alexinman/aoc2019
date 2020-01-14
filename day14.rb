require_relative 'input_reader'

class Reaction
  attr_accessor :inputs, :output

  def initialize(encoded_reaction)
    _, encoded_inputs, encoded_output = /(.*)\s=>\s(.*)/.match(encoded_reaction).to_a
    self.inputs = encoded_inputs.split(', ').map { |encoded_input| ReactionComponent.new(encoded_input) }
    self.output = ReactionComponent.new(encoded_output)
    output.chemical.reaction = self
  end

  def inspect
    encode.inspect
  end

  def encode
    "#{inputs.map(&:encode).join(', ')} => #{output.encode}"
  end
end

class ReactionComponent
  attr_accessor :chemical, :quantity

  def initialize(encoded_component)
    _, quantity, name = /(\d+) ([A-z]+)/.match(encoded_component).to_a
    self.chemical = Chemical.find(name)
    self.quantity = quantity.to_i
  end

  def encode
    "#{quantity} #{chemical.name}"
  end
end

class Chemical
  attr_accessor :name, :reaction

  def initialize(n)
    self.name = n
  end

  def self.find(n)
    @chemicals ||= {}
    @chemicals[n] ||= Chemical.new(n)
  end

  def inspect
    name.inspect
  end
end

reactions = InputReader.read.map { |er| Reaction.new(er) }

def ore_needed_for_fuel(x, reactions)
  ore = Chemical.find('ORE')
  fuel = Chemical.find('FUEL')
  chemicals_needed = Hash.new(0)
  chemicals_needed[fuel] = x
  while reactions.any?
    reactions.reject! do |reaction|
      output_chemical = reaction.output.chemical
      next false if reactions.any? { |r| r.inputs.any? { |rc| rc.chemical == output_chemical } }

      min_quantity = chemicals_needed[output_chemical]
      batch_quantity = reaction.output.quantity
      num_batches = (min_quantity.to_f / batch_quantity).ceil
      reaction.inputs.each do |rc|
        chemicals_needed[rc.chemical] += rc.quantity * num_batches
      end
      true
    end
  end
  chemicals_needed[ore]
end

part_1 = ore_needed_for_fuel(1, reactions.dup)
puts "Part 1:", part_1 # 201324

one_trillion = 1_000_000_000_000
fuel = one_trillion / part_1
increment = 1_000_000
while increment >= 1
  while ore_needed_for_fuel(fuel, reactions.dup) <= one_trillion
    fuel += increment
  end
  fuel -= increment
  increment /= 10
end
puts "Part 2:", fuel # 6326857