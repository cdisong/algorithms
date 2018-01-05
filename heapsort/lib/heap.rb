class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length 
  end

  def extract
    raise 'empty' if count == 0 
    @store[0], @store[count-1] = @store[count-1], @store[0]
    # @store[count-1] = @store[0]
    value = @store.pop
    BinaryMinHeap::heapify_down(@store,0)
    value 
  end

  def peek
    raise 'empty' if count == 0 
    @store[0]
  end

  def push(val)
    @store << val 
    BinaryMinHeap::heapify_up(@store, @store.length - 1)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    first_child = (parent_index * 2) + 1 
    second_child = (parent_index * 2) + 2 
    children << first_child if first_child < len
    children << second_child if second_child < len 
    children 
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0 
    (child_index - 1) / 2  
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    child_indices = BinaryMinHeap::child_indices(len, parent_idx)
    if child_indices.empty?
      return 
    end 
    prc ||= Proc.new { |i, j| i <=> j }
    child_indices.each_with_index do |child_idx, idx|
      if idx == 0 && prc.call(array[child_indices[0]], array[child_indices[-1]]) > 0 
        next 
      end 
      if (prc.call(array[child_idx], array[parent_idx])) < 0 
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        # array[parent_idx] = array[child_idx]
        BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
      end 
    end 
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    if child_idx == 0 
      return 
    end 
    prc ||= Proc.new{ |i, j| i <=> j}
    parent_idx = BinaryMinHeap::parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) < 0 
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      # array[parent_idx] = array[child_idx]
      BinaryMinHeap::heapify_up(array, parent_idx, array.length, &prc)
    end 
    array 
  end
end


# def timesort(*args)
# end 