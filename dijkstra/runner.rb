module Dijkstra
  class Runner

    def self.run
      source_vertices = [7,37,59,82,99,115,133,165,188,197]
      graph = Graph.new('data/dijkstraData.txt')
      graph.shortest_path_distances(source_vertices)
    end

  end
end