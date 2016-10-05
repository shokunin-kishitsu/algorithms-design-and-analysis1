module Median
  class MaxHeap < Base

    private

    def ok?(p, c)
      p.nil? || c.nil? || arr[p-1].nil? || arr[c-1].nil? || arr[p-1] >= arr[c-1]
    end

    def fav_child(c1, c2)
      if arr[c2-1].nil?
        c1
      else
        arr[c1-1] >= arr[c2-1] ? c1 : c2
      end
    end
  end
end