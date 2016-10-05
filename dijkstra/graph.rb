require 'pp'
require 'csv'
require 'set'

module Dijkstra
  class Graph

    attr_accessor :vertices

    def initialize(file_path)
      @vertices = []
      puts "Initializing graph..."
      CSV.foreach(file_path) do |row|
        data = row.join(",").split("\t")
        index = data[0].to_i
        vertices[index] = Vertex.new(data.drop(1))
      end
    end

    def size
      vertices.size-1
    end

    def shortest_path_distances(source_vertices)
      initXV
      while @X != @V do
        explored = @X
        unexplored = @V - @X
        local_min = 1_000_000
        best_w = nil
        explored.each do |v|
          possible_leads = vertices[v].adjacents.keys.to_set - explored
          possible_leads.each do |w|
            path_distance = @A[v] + vertices[v].adjacents[w]
            if path_distance < local_min
              @A[w] = local_min = path_distance
              best_w = w
            end
          end
        end
        @X << best_w
      end
      source_vertices.map do |x|
        @A[x]
      end
    end

    private

    def initXV
      @X, @V, @A = Set.new([1]), Set.new, []
      1.upto(200).each do |i|
        @V << i
        @A[i] = 1_000_000
      end
      @A[1] = 0
    end

  end
end