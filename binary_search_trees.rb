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
  attr_accessor :root

  def initialize(array)
    @array = array
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
end

arr1 = [1, 2, 3, 4, 5, 6, 7, 8]
bst = Tree.new(arr1)
p bst.root
