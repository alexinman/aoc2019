require_relative 'int_code_computer'
require_relative 'test_helper'

cpu = IntCodeComputer.new([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 7
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 8
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 9
cpu.run
assert_equal 0, cpu.output

cpu = IntCodeComputer.new([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 7
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 8
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8])
cpu.input = 9
cpu.run
assert_equal 0, cpu.output

cpu = IntCodeComputer.new([3, 3, 1108, -1, 8, 3, 4, 3, 99])
cpu.input = 7
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 3, 1108, -1, 8, 3, 4, 3, 99])
cpu.input = 8
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 3, 1108, -1, 8, 3, 4, 3, 99])
cpu.input = 9
cpu.run
assert_equal 0, cpu.output

cpu = IntCodeComputer.new([3, 3, 1107, -1, 8, 3, 4, 3, 99])
cpu.input = 7
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 3, 1107, -1, 8, 3, 4, 3, 99])
cpu.input = 8
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 3, 1107, -1, 8, 3, 4, 3, 99])
cpu.input = 9
cpu.run
assert_equal 0, cpu.output

cpu = IntCodeComputer.new([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9])
cpu.input = -1
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9])
cpu.input = 0
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9])
cpu.input = 1
cpu.run
assert_equal 1, cpu.output

cpu = IntCodeComputer.new([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1])
cpu.input = -1
cpu.run
assert_equal 1, cpu.output
cpu = IntCodeComputer.new([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1])
cpu.input = 0
cpu.run
assert_equal 0, cpu.output
cpu = IntCodeComputer.new([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1])
cpu.input = 1
cpu.run
assert_equal 1, cpu.output

cpu = IntCodeComputer.new([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
cpu.input = 6
cpu.run
assert_equal 999, cpu.output
cpu = IntCodeComputer.new([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
cpu.input = 7
cpu.run
assert_equal 999, cpu.output
cpu = IntCodeComputer.new([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
cpu.input = 8
cpu.run
assert_equal 1000, cpu.output
cpu = IntCodeComputer.new([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
cpu.input = 9
cpu.run
assert_equal 1001, cpu.output
cpu = IntCodeComputer.new([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
cpu.input = 10
cpu.run
assert_equal 1001, cpu.output