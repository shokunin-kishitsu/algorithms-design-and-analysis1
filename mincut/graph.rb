require 'pp'
require 'csv'

module Mincut
  class Graph
    attr_reader :vertices

    def initialize(file_path)
      @vertices = {}
      CSV.foreach(file_path) do |row|
        vertex_data = row.first.split("\t").map(&:to_i)
        vertices[vertex_data.first] = Vertex.new(vertex_data)
      end
    end

    def [](index)
      vertices[index]
    end

    def merge(vertex1, vertex2)
      # merge to first
      vertex1.adjacent_vertices += vertex2.adjacent_vertices
      # vertex1.adjacent_vertices.uniq!
      vertices = update_refs(vertex2.index, vertex1.index)
      vertex1.remove_self_refs
      vertices.delete(vertex2.index)
    end

    def size
      vertices.size
    end

    def random_edge
      return nil if size <= 2
      keys = vertices.keys
      random = Random.new
      rand1 = random.rand(size)
      vertex1 = vertices[keys[rand1]]
      rand2 = vertex1.adjacent_vertices[random.rand(vertex1.adjacent_vertices.size)]
      vertex2 = vertices[rand2]
      return [vertex1, vertex2]
    end

    private

    def update_refs(old_index, new_index)
      vertices.each_value do |vertex|
        vertex.adjacent_vertices.collect!{ |i| i == old_index ? new_index : i }
      end
    end
  end
end