module SCC
  class Vertex

    attr_accessor :leads, :explored

    def initialize()
      @leads = []
      @expored = false
    end

    def explored?
      explored
    end
  end
end