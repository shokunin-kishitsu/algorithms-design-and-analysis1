module SCC
  class Runner

    def self.run
      Graph.new('data/SCC.txt').compute_sccs
    end

  end
end