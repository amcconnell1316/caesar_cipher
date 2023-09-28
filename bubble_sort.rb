# frozen_string_literal: true

def bubble_sort(array)
  num_loops = array.length - 2
  sorted_array = array.clone
  num_loops.downto(0) do |i|
    0.upto(i) do |j|
      swap!(sorted_array, j, j + 1) if sorted_array[j] <= sorted_array[j + 1]
    end
  end
  sorted_array
end

def swap!(array, idx_i, idx_j)
  temp_val = array[idx_j]
  array[idx_j] = array[idx_i]
  array[idx_i] = temp_val
end

p bubble_sort([4, 3, 78, 2, 0, 2])
p bubble_sort([34, 3, 5, 6, 1, 0])
p bubble_sort([0, 1, 2, 3])
#=> [0,2,2,3,4,78]
