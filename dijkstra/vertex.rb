module Dijkstra
  class Vertex

    attr_accessor :adjacents

    def initialize(data)
      @adjacents = {}
      data.each do |lead|
        index, length = lead.split(",").map(&:to_i)
        adjacents[index] = length
      end
    end
  end
end