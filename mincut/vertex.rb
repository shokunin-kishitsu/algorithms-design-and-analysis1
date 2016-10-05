class Vertex

  attr_accessor :index, :adjacent_vertices

  def initialize(data)
    @index = data.first
    @adjacent_vertices = data.drop(1)
  end

  def remove_self_refs
    adjacent_vertices.delete_if {|i| i == index }
  end
end