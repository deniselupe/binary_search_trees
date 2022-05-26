# class to instantiate binary search tree nodes
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# class for instantiating binary search trees
class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = clean_array(array)
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
  def sort(arr)
    return arr if arr.length <= 1

    left = arr[0...arr.length / 2]
    right = arr[arr.length / 2..-1]
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

  # Removes duplicate values from array
  def remove_arr_dupes(arr)
    uniq_arr_count = arr.reduce({}) do |hash, val|
      hash[val] ||= 0
      hash[val] += 1
      hash
    end

    uniq_arr_count.keys
  end

  def clean_array(arr)
    new_arr = remove_arr_dupes(arr)
    sort(new_arr)
  end

  def insert(value, root = @root)
    if root.nil?
      root = Node.new(value)
      return root
    end

    root.left = insert(value, root.left) if value < root.data
    root.right = insert(value, root.right) if value > root.data
    root
  end

  # when value matches node, traverse for inorder successor
  # if node has a right subtree
  def successor(node)
    current_node = node

    until current_node.left.nil?
      current_node = current_node.left
    end

    current_node.data
  end

  # when value matches node, traverse for inorder predecessor
  # if node has no right subtree but has a left subtree
  def predecessor(node)
    current_node = node

    until current_node.right.nil?
      current_node = current_node.right
    end

    current_node.data
  end

  def delete(value, root = @root)
    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    elsif value == root.data
      # deletes node if it has no children
      if root.left.nil? && root.right.nil?
        root = nil
      # deletes inorder successor node if right subtree exists
      elsif !root.right.nil?
        temp = successor(root.right)
        root.data = temp
        root.right = delete(temp, root.right)
      # deletes inorder predecessor if no right subtree exists
      elsif !root.left.nil?
        temp = predecessor(root.left)
        root.data = temp
        root.left = delete(temp, root.left)
      end
    end

    root
  end

  def find(value, root = @root)
    return nil if root.nil?

    if value < root.data
      find(value, root.left)
    elsif value > root.data
      find(value, root.right)
    elsif value == root.data
      return root
    end
  end

  # Accepts a block and performs block computation on each node in breadth-first inorder
  # Otherwise returns an array of node values in breadth-first order if no block is given
  def breadth_first
    queue = [@root]
    result = []

    until queue.empty?
      current_node = queue.pop()
      block_given? ? yield(current_node) : result << current_node.data
      queue.unshift(current_node.left) unless current_node.left.nil?
      queue.unshift(current_node.right) unless current_node.right.nil?
    end

    result unless block_given?
  end

  def preorder
    stack = [@root]
    result = []

    until stack.empty?
      current_node = stack.pop()
      block_given? ? yield(current_node) : result << current_node.data
      stack.push(current_node.right) unless current_node.right.nil?
      stack.push(current_node.left) unless current_node.left.nil?
    end

    result unless block_given?
  end

  def inorder
    stack = []
    result = []
    current_node = @root

    # Will loop until stack is empty and current_node is nil
    until stack.empty? && current_node.nil?
      # when current_node is not nil, push current_node to stack and set current_node to it's left child node
      if !current_node.nil?
        stack.push(current_node)
        current_node = current_node.left
      # if current_node is nil, set current_node to last element in stack array
      # push the new current_node value to the result array
      # then set current_node to its right child node
      else
        current_node = stack.pop()
        block_given? ? yield(current_node) : result << current_node.data
        current_node = current_node.right
      end
    end

    result unless block_given?
  end

  def postorder
    stack = [@root]
    result = []

    until stack.empty?
      # node values will be appended to the result array backwards <root><right><left>
      current_node = stack.pop()
      result << current_node
      stack.push(current_node.left) unless current_node.left.nil?
      stack.push(current_node.right) unless current_node.right.nil?
    end

    # afterwards the result array will be reversed so that nodes are in <left><right><root> order
    result = result.reverse

    if block_given?
      result.each do |node|
        yield(node)
      end
    else
      result.map { |node| node.data }
    end
  end

  def height(root = @root)
    # returns -1 if root is nil
    return -1 if root.nil?

    left = height(root.left)
    right = height(root.right)

    # after collecting heights of left and right subtrees
    # assign the bigger of the two values to variable biggest_num
    # add 1 to biggest_num to return actual height for node
    biggest_num = left > right ? left : right
    biggest_num += 1
  end

  # using similar logic to find(), will count the number of nodes traversed
  # from root node to the given node being searched
  def depth(node, root = @root, count = -1)
    # returns nil for nodes that do not exist in the binary search tree
    return nil if root.nil?

    count += 1

    if node < root.data
      # will only call depth() on root.left if node is less than root.data
      depth(node, root.left, count)
    elsif node > root.data
      # will only call depth() on root.right if node is more than root.data
      depth(node, root.right, count)
    elsif node == root.data
      return count
    end
  end
end

arr1 = [6, 5, 3, 1, 8, 7, 2, 4, 6, 7, 1, 6, 6]
bst = Tree.new(arr1)

puts "Height for Root Node 4 is #{bst.height}"
