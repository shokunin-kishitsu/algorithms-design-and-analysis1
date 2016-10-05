module Median
  class Base

    attr_accessor :arr

    def initialize
      @arr = []
    end

    def <<(num)
      arr << num
      c = arr.size
      p = parent(c)
      while !ok?(p, c) do
        swap(p, c)
        c = p
        p = parent(c)
      end
      self
    end

    def size
      arr.size
    end

    def root
      arr[0]
    end

    def extract_root
      ex_root = arr.shift
      if arr.any?
        new_root = arr.pop
        arr.unshift(new_root)
        p = 1
        c1, c2 = children(p)
        while !ok?(p, c1) || !ok?(p, c2) do
          chosen_child = fav_child(c1, c2)
          swap(p, chosen_child)
          p = chosen_child
          c1, c2 = children(p)
        end
      end
      ex_root
    end

    private

    def swap(i, j)
      arr[i-1], arr[j-1] = arr[j-1], arr[i-1]
    end

    def parent(i)
      i == 1 ? nil : i/2
    end

    def children(i)
      return i*2, i*2+1
    end

    def ok?(parent, child)
      raise
    end

    def fav_child(c1, c2)
      raise
    end

  end
end