def bubble_sort(array)
    numLoops = array.length-2
    sorted_array = array.clone
    numLoops.downto(0) do |i|
        0.upto(i) do |j|
            if sorted_array[j] > sorted_array[j+1]
                tempVal = sorted_array[j+1]
                sorted_array[j+1] = sorted_array[j]
                sorted_array[j] = tempVal
            end
        end
    end
    sorted_array
end

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([34,3,5,6,1,0])
p bubble_sort([0,1,2,3])
#=> [0,2,2,3,4,78]