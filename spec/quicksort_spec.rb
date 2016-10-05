require 'spec_helper'

describe Quicksort do

  describe '#partition' do
    it 'partitions correctly' do
      qs = Quicksort.new [2, 1, 3]
      a, p = qs.partition(qs.data, 0)
      expect(a[1]).to eq 2

      qs = Quicksort.new [443, 54, 34, 67]
      a, p = qs.partition(qs.data, 0)
      expect(a[3]).to eq 443
    end
  end

  describe '#sort' do
    it 'sorts correctly when pivot is 0' do
      p = Proc.new {|a| 0 }

      qs = Quicksort.new [443, 54, 34, 67]
      expect(qs.sort(qs.data, &p)).to eq [34, 54, 67, 443]

      qs = Quicksort.new [443, 54, 34, 67, 5, 4, 3]
      expect(qs.sort(qs.data, &p)).to eq [3, 4, 5, 34, 54, 67, 443]
    end

    it 'sorts correctly when pivot is last' do
      p = Proc.new {|a| a.size - 1 }

      qs = Quicksort.new [443, 54, 34, 67]
      expect(qs.sort(qs.data, &p)).to eq [34, 54, 67, 443]

      qs = Quicksort.new [443, 54, 34, 67, 5, 4, 3]
      expect(qs.sort(qs.data, &p)).to eq [3, 4, 5, 34, 54, 67, 443]
    end

    it 'sorts correctly when pivot is a median' do
      p = Proc.new do |a|
        mid_index = a.size.even? ? a.size/2-1 : a.size/2
        middle = a[mid_index]
        median = [a.first, middle, a.last].sort[1]
        case median
        when a.first
          0
        when a.last
          a.size-1
        when middle
          mid_index
        end
      end

      qs = Quicksort.new [443, 54, 34, 67]
      expect(qs.sort(qs.data, &p)).to eq [34, 54, 67, 443]

      qs = Quicksort.new [443, 54, 34, 67, 5, 4, 3]
      expect(qs.sort(qs.data, &p)).to eq [3, 4, 5, 34, 54, 67, 443]
    end
  end

end