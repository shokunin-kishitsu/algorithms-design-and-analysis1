module TwoSum
  class Runner

    def self.run
      h1 = {}
      h2 = {}
      num = 0
      data = load_data
      data.each do |i|
        h1[i] = 1
      end
      -10_000.upto(10_000).each do |t|
        # puts "t = #{t}, h1 = #{h1.size}, num = #{num}"
        puts("t = #{t}, num = #{num}") if t % 10 == 0
        h1.each_key do |x|
          y = t-x
          if !h1[y].nil?
            # eliminating x and y when there's a match
            h1.delete(y)
            h1.delete(x)
            num += 1
            # skipping to the next t when there's a match
            break
          end
        end
      end
      num
    end

    def self.run2
      h1 = {}
      num = 0
      data = load_data
      data.each do |i|
        h1[i] = 1
      end
      -10_000.upto(10_000).each do |t|
        puts("t = #{t}, num = #{num}") if t % 10 == 0
        h1.each_key do |x|
          y = t-x
          if !h1[y].nil? && x != y
            num += 1
            # skipping to the next t when there's a match
            break
          end
        end
      end
      num
    end

    def self.load_data
      file = File.read('data/2sum.txt')
      file.split("\n").map(&:to_i)
    end

  end
end