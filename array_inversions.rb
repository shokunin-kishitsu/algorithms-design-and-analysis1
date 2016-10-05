file = File.read('IntegerArray.txt')
# file = File.read('test2.txt')
arr = file.split("\n").map(&:to_i)

# puts "total: #{ arr.size }"

def count_split_and_merge(arr1, arr2)
  # puts "merging #{ arr1.inspect } and #{ arr2.inspect }"
  inversion_count = 0
  result = []
  n = arr1.size + arr2.size
  j = 0
  k = 0
  n.times do |i|
    # puts "merging element #{i}"
    if arr1[j].nil?
      result[i] = arr2[k]
      k += 1
    elsif arr2[k].nil?
      result[i] = arr1[j]
      j += 1
    elsif arr1[j] < arr2[k]
      result[i] = arr1[j]
      j += 1
    else
      result[i] = arr2[k]
      inversion_count += arr1.size - j
      k += 1
    end
  end
  # puts "merge result: #{ result }"
  return result, inversion_count
end

def split array
  n = array.size / 2
  n += 1 if array.size.odd?
  # puts "slicing by #{ n }"
  array.each_slice(n).to_a
end

def sort array
  # puts "sorting array of length #{ array.size }"
  return array if array.size == 1
  if array.size == 2
    array = array.reverse if array[0] > array[1]
    return array
  end
  left_half, right_half = split(array)
  puts left_half.inspect
  puts right_half.inspect
  count_split_and_merge(sort(left_half), sort(right_half))
end

def count_and_sort array
  return array, 0 if array.size == 1
  if array.size == 2
    if array[0] > array[1]
      return array.reverse, 1
    else
      return array, 0
    end
  end

  left_half, right_half = split(array)
  sorted1, x = count_and_sort(left_half)
  sorted2, y = count_and_sort(right_half)
  sorted_and_merged, z = count_split_and_merge(sorted1, sorted2)
  return sorted_and_merged, x + y + z
end

puts count_and_sort(arr)[1]