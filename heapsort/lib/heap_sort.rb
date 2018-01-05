require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new{ |i, j| j <=> i }
    (1...self.length).each do |idx|
      BinaryMinHeap::heapify_up(self, idx, self.length, &prc)
    end 
    (self.length - 1).downto(0) do |idx| 
      self[0], self[idx] = self[idx], self[0]
      # self[idx] = self[0]
      BinaryMinHeap::heapify_down(self, 0, idx, &prc)
    end 
    self 
  end
end

# solution HA ##### 
# def heap_sort! 
#   2.upto(count).each do |heap_sz|
#     BinaryMinHeap.heapify_up(self, heap_sz - 1, heap_sz)
#   end 
#   count.downto(2).each do |heap_sz|
#     self[heap_sz -1], self[0] - self[0], self[heap_sz -1] 
#     BinaryMinHeap.heapify_down(self, 0, heap_sz - 1)
#   end 
#   self.reverse! 
# end 


