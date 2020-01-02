class IntCodeComputer
  OpCodes = {
      1 => :add,
      2 => :multiply,
      3 => :read_input,
      4 => :write_output,
      5 => :jump_if_true,
      6 => :jump_if_false,
      7 => :less_than,
      8 => :equals,
      99 => :halt
  }.freeze

  ParameterModes = {
      position: 0,
      immediate: 1
  }.freeze

  attr_accessor :memory, :instruction_pointer, :step_value, :input, :output

  def initialize(memory)
    self.memory = memory.dup
  end

  def run
    self.instruction_pointer = 0
    while instruction != :halt
      send(instruction)
    end
    self
  end

  def [](addr)
    memory[addr]
  end

  private

  def instruction
    OpCodes[memory[instruction_pointer] % 100]
  end

  def step(value)
    self.instruction_pointer += value
  end

  def add
    memory[param_pos(3)] = param_value(1) + param_value(2)
    step(4)
  end

  def multiply
    memory[param_pos(3)] = param_value(1) * param_value(2)
    step(4)
  end

  def read_input
    memory[param_pos(1)] = input
    step(2)
  end

  def write_output
    self.output = param_value(1)
    step(2)
  end

  def jump_if_true
    return step(3) if param_value(1) == 0
    self.instruction_pointer = param_value(2)
  end

  def jump_if_false
    return step(3) unless param_value(1) == 0
    self.instruction_pointer = param_value(2)
  end

  def less_than
    memory[param_pos(3)] = param_value(1) < param_value(2) ? 1 : 0
    step(4)
  end

  def equals
    memory[param_pos(3)] = param_value(1) == param_value(2) ? 1 : 0
    step(4)
  end

  def parameter_mode(offset)
    (memory[instruction_pointer] / (10 ** (offset + 1))) % (10 ** offset)
  end

  def param_value(offset)
    memory[param_pos(offset)]
  end

  def param_pos(offset)
    case parameter_mode(offset)
    when ParameterModes[:position]
      memory[instruction_pointer + offset]
    when ParameterModes[:immediate]
      instruction_pointer + offset
    else
      raise RuntimeError, 'invalid parameter mode'
    end
  end
end
