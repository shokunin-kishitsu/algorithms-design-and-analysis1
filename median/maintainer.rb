module Median
  class Maintainer

    attr_reader :min_heap, :max_heap

    def initialize
      @max_heap = MaxHeap.new
      @min_heap = MinHeap.new
    end

    def feed(i)
      puts i
      if max_heap.root == nil || i <= max_heap.root
        max_heap << i
      elsif min_heap.root == nil || i >= min_heap.root
        min_heap << i
      else
        max_heap << i
      end
      rebalance
      self
    end

    def get
      if size.even? || max_heap.size > min_heap.size
        max_heap.root
      else
        min_heap.root
      end
    end

    def size
      min_heap.size + max_heap.size
    end

    private

    def rebalance
      if min_heap.size - max_heap.size > 1
        max_heap << min_heap.extract_root
      elsif max_heap.size - min_heap.size > 1
        min_heap << max_heap.extract_root
      end
    end

  end
end