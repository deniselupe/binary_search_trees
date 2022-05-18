# class to instantiate binary search tree nodes
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = sort(array)
    @root = build_tree(@array, 0, @array.length - 1)
  end

  def build_tree(array, min, max)
    return nil if min > max
    mid = (min + max) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array, min, mid - 1)
    node.right = build_tree(array, mid + 1, max)
    node
  end

  # Perform Merge Sort to sort the array in ascending order
  def sort(array)
    return array if array.length <= 1
    left = array[0...array.length / 2]
    right = array[array.length / 2..-1]
    sort_left = sort(left)
    sort_right = sort(right)
    merge(sort_left, sort_right)
  end

  # Perform Merge Sort to sort the array in ascending order
  def merge(left_arr, right_arr)
    return left_arr if right_arr.empty?
    return right_arr if left_arr.empty?
    smallest_num = left_arr[0] < right_arr[0] ? left_arr.shift : right_arr.shift
    sorted_arr = merge(left_arr, right_arr)
    [smallest_num, *sorted_arr]
  end
end

arr1 = [6, 5, 3, 1, 8, 7, 2, 4]
bst = Tree.new(arr1)
p "Array is #{bst.array}"
p bst.root
