class IntCodeComputer
  ADD = 1
  MULTIPLY = 2
  HALT = 99

  attr_reader :memory, :instruction_pointer

  def initialize(memory)
    @memory = memory.dup
  end

  def run
    @instruction_pointer = 0
    while instruction != :halt
      send(instruction) and step
    end
    self
  end

  def [](addr)
    memory[addr]
  end

  def inspect
    "{\n\t#{memory.each_with_index.map { |int, i| "#{i} => #{int}" }.join(",\n\t")}\n}"
  end

  private

  def instruction
    case memory[instruction_pointer]
    when ADD
      :add
    when MULTIPLY
      :multiply
    when HALT
      :halt
    else
      raise RuntimeError
    end
  end

  def step
    @instruction_pointer += 4
  end

  def add
    memory[memory[instruction_pointer+3]] = memory[memory[instruction_pointer+1]] + memory[memory[instruction_pointer+2]]
  end

  def multiply
    memory[memory[instruction_pointer+3]] = memory[memory[instruction_pointer+1]] * memory[memory[instruction_pointer+2]]
  end
end
