module Median
  class Runner

    def self.run
      data = load_data
      median = Maintainer.new
      data.reduce(0) { |sum, i| sum + median.feed(i).get } % 10_000
    end

    def self.load_data
      file = File.read('data/Median.txt')
      file.split("\n").map(&:to_i)
    end

  end
end