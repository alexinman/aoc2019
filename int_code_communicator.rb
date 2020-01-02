class IntCodeCommunicator
  def initialize(memory, phase_settings)
    self.cpus = phase_settings.map do |phase_setting|
      IntCodeComputer.new(memory).tap do |cpu|
        cpu.input = phase_setting
        cpu.run
      end
    end
  end

  def run
    cpus.first.input = 0
    cpus.first.run
    cpus.cycle.each_cons(2) do |prev, curr|
      break if curr.halted?
      curr.input = prev.output
      curr.run
    end
    self
  end

  def output
    cpus.last.output
  end

  private

  attr_accessor :cpus
end