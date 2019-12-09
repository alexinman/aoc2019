class InputReader
  def self.read
    File.open("#{caller.first.split(".rb").first}.input").readlines.map(&:chomp)
  end
end
