module Mincut
  class Runner

    def self.run
      graph = Graph.new('data/kargerMinCut.txt')
      while (random_edge = graph.random_edge) != nil
        graph.merge(random_edge.first, random_edge.last)
      end
      graph.vertices.values.first.adjacent_vertices.size
    end

  end
end