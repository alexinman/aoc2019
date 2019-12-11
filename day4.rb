require_relative 'input_reader'

def valid_password(password)
  cons = password.to_s.split('').each_cons(2)
  cons.all? { |a, b| a <= b } && cons.any? { |a, b| a == b }
end

min, max = InputReader.read.first.split('-').map(&:to_i)
puts "Part 1:", (min..max).count(&method(:valid_password))

def valid_password_v2(password)
  digits = "#{("0".ord-1).chr}#{password}#{("9".ord+1).chr}".split('')
  cons2 = digits.each_cons(2)
  cons4 = digits.each_cons(4)
  cons2.all? { |a, b| a <= b } && cons2.any? { |a, b| a == b } && cons4.any? { |a, b, c, d| a != b && b == c && c != d }
end

puts "Part 2:", (min..max).count(&method(:valid_password_v2))