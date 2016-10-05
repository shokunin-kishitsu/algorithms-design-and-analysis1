class Quicksort

	attr_reader :data, :comparisons

	def initialize data
		@data = data
		@comparisons = 0
	end

	def read_file file_name
		@data = File.read(file_name).split("\n").collect(&:to_i)
	end

	def partition(a, p)
	  a[0], a[p] = a[p], a[0] if p != 0 # preprocessing step
	  p = a[0]
	  i = 1
	  (1..(a.size-1)).each do |j|
	    if a[j] < p
	      a[i], a[j] = a[j], a[i]
	      i += 1
	    end
	  end
	  a[i-1], a[0] = a[0], a[i-1]
	  return a, i-1
	end

	def sort(a, &block)
	  return a if a.size == 1
	  @comparisons += a.size - 1
	  p = block.call(a)
	  a, p = partition(a, p)
	  left_part = p > 0 ? sort(a[0..(p-1)], &block) : []
	  right_part = p < a.size-1 ? sort(a[(p+1)..(a.size-1)], &block) : []
	  left_part + [a[p]] + right_part
	end
end

# 162085
# 164123
# 138382