def assert(value, msg = nil)
  msg ||= "Expected <#{value.inspect}> to be truthy."
  raise msg unless value
end

def assert_equal(expected, actual, msg = nil)
  msg ||= "Expected <#{actual.inspect}> to equal <#{expected.inspect}>."
  assert(expected == actual, msg)
end