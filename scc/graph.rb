require 'pp'
require 'csv'

module SCC
  class Graph
    attr_accessor :vertices_rev, :vertices, :vertices_by_finishing_time, :leaders

    def initialize(file_path)
      @vertices_rev = []
      @vertices = []
      @sccs = []
      @t = 0
      @s = nil
      @vertices_by_finishing_time = []
      @leaders = {}

      puts "Initializing graph..."
      i = 1
      CSV.foreach(file_path) do |row|
        edge = row.first.strip.split(" ").map(&:to_i)
        add edge
        i += 1
      end
    end

    def add edge
      vertices_rev[edge.first] ||= Vertex.new
      vertices_rev[edge.last] ||= Vertex.new
      vertices_rev[edge.last].leads << edge.first

      vertices[edge.first] ||= Vertex.new
      vertices[edge.last] ||= Vertex.new
      vertices[edge.first].leads << edge.last
    end

    def size(arr)
      arr.size-1
    end

    def compute_sccs
      first_pass
      second_pass
      sccs.first(5)
    end

    private

    def first_pass
      puts "First pass"
      dfs_loop1
    end

    def second_pass
      puts "Second pass"
      dfs_loop2
    end

    def dfs_loop1()
      size(vertices_rev).downto(1).each do |i|
        if !vertices_rev[i].explored?
          puts("DFS loop 1 - #{ i }") if i % 1000 == 0
          dfs1(i)
        end
      end
    end

    def dfs1(i)
      stack = []
      vertices_rev[i].explored = true
      stack.push [i, vertices_rev[i].leads]

      while stack.any? do
        index, leads = *stack.last
        break_out = false
        leads.each do |j|
          if !vertices_rev[j].explored?
            vertices_rev[j].explored = true
            stack.push [j, vertices_rev[j].leads]
            break_out = true
            break
          end
        end
        next if break_out
        stack.pop
        @t = @t + 1
        vertices_by_finishing_time[@t] = index
      end
    end

    def dfs_loop2()
      size(vertices).downto(1).each do |i|
        index = vertices_by_finishing_time[i]
        if !vertices[index].explored?
          @s = index
          puts("DFS loop 2 - #{ i } - s: #{ @s }") if i % 1000 == 0
          dfs2(index)
        end
      end
    end

    def dfs2(i)
      stack = []
      vertices[i].explored = true
      # leaders[i] = @s
      leaders[@s] ||= []
      leaders[@s] << i
      stack.push [i, vertices[i].leads]

      while stack.any? do
        index, leads = *stack.last
        break_out = false
        leads.each do |j|
          if !vertices[j].explored?
            vertices[j].explored = true
            # leaders[j] = @s
            leaders[@s] ||= []
            leaders[@s] << j
            stack.push [j, vertices[j].leads]
            break_out = true
            break
          end
        end
        next if break_out
        stack.pop
      end
    end

    def sccs
      result = []
      leaders.each do |key, value|
        result << leaders[key].size
      end
      result.sort.reverse
    end
  end
end