class InputReader
  def self.read
    read_file.map(&:chomp)
  end

  def self.read_csv
    read_file.map { |line| line.chomp.split(',') }
  end

  private

  def self.read_file
    File.open(input_file).readlines
  end

  def self.input_file
    "#{caller[2].split(".rb").first}.input"
  end
end
