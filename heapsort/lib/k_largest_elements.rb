require_relative 'heap'

def k_largest_elements(array, k)
    prc = Proc.new { |i, j| j <=> i }

    (1...array.length).each do |idx|
        BinaryMinHeap::heapify_up(array, idx, array.length, &prc)
    end

    (array.length - 1).downto(0) do |idx|
        array[0], array[idx] = array[idx], array[0]
        BinaryMinHeap::heapify_down(array, 0, idx, &prc)
    end

    array[-k..-1]
end
