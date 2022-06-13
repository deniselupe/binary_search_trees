# Node class that will be used for both the iterative and recursive Depth-First Preorder Traversal
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

# Iterative Depth-First Preorder Traversal
def preorder_iter(root = nil)
  return [] if root == nil
  stack = [root]
  result = []

  while stack.length > 0 do
    current_val = stack.pop()
    result << current_val.value
    stack.push(current_val.right) if current_val.right
    stack.push(current_val.left) if current_val.left
  end

  result
end

# Recursive Depth-First Preorder Traversal v1
# Returns a empty array [] if root is nil
# This ensures that a.left returns []
def preorder_recur1(root = nil, result = [])
  return [] if root == nil
  result << root.value

  left = preorder_recur1(root.left, result)
  right = preorder_recur1(root.right, result)

  result
end

# Recursive Depth-First Preorder Traversal v2
# This method ensures we don't have to use a result variable
# Returns: F, D, B, A, C, E, J, G, I, H, K
def preorder_recur2(root = nil)
  return [] if root == nil

  left = preorder_recur2(root.left)
  right = preorder_recur2(root.right)

  [root.value, *left, *right]
end

# Iterative Depth-First Inorder Traversal
def inorder_iter(node)
  stack = []
  result = []
  current_node = node

  until stack.empty? && current_node.nil?
    if !current_node.nil?
      stack.push(current_node)
      current_node = current_node.left
    elsif current_node.nil?
      current_node = stack.pop()
      result << current_node.data
      current_node = current_node.right
    end
  end

  result
end

# Recursive Depth-First Inorder Traversal v1
# Returns: A, B, C, D, E, F, G, H, I, J, K
def inorder_recur1(root = nil, result = [])
  return [] if root == nil
  inorder_recur1(root.left, result)
  result << root.value
  inorder_recur1(root.right, result)
  result
end

# Recursive Depth-First Inorder Traversal v2
# Returns: A, B, C, D, E, F, G, H, I, J, K
def inorder_recur2(root = nil)
  return [] if root == nil
  left = inorder_recur2(root.left)
  right = inorder_recur2(root.right)
  [*left, root.value, *right]
end

# Iterative Depth-First Postorder Traversal
def postorder_iter(node)
  stack = [node]
  result = []

  until stack.empty?
    current_node = stack.pop()
    result << current_node.data
    stack.push(current_node.left) unless current_node.left.nil?
    stack.push(current_node.right) unless current_node.right.nil?
  end

  result.reverse
end

# Recursive Depth-First Postorder Traversal v1
# Returns: A, C, B, E, D, H, I, G, K, J, F
def postorder_recur1(root = nil, result = [])
  return [] if root == nil
  postorder_recur1(root.left, result)
  postorder_recur1(root.right, result)
  result << root.value
  result
end

# Recursive Depth-First Postorder Traversal v2
# Returns: A, C, B, E, D, H, I, G, K, J, F
def postorder_recur2(root = nil)
  return [] if root == nil
  left = postorder_recur2(root.left)
  right = postorder_recur2(root.right)
  [*left, *right, root.value]
end

a = Node.new('a')
c = Node.new('c')
b = Node.new('b'); b.left = a; b.right = c
e = Node.new('e')
d = Node.new('d'); d.left = b; d.right = e
h = Node.new('h')
i = Node.new('i'); i.left = h;
g = Node.new('g'); g.right = i
k = Node.new('k')
j = Node.new('j'); j.left = g; j.right = k
f = Node.new('f'); f.left = d; f.right = j

one = Node.new(1)
two = Node.new(2)
three = Node.new(3)
four = Node.new(4)
five = Node.new(5)
six = Node.new(6)
seven = Node.new(7)
eight = Node.new(8)
nine = Node.new(9)

four.left = two; four.right = six
two.left = one; two.right = three
six.left = five; six.right = seven
seven.right = eight
