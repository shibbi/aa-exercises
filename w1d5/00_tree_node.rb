class PolyTreeNode
  attr_accessor :children
  attr_reader :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    if @parent != new_parent
      @parent.children.delete(self) unless @parent.nil?
      @parent = new_parent
      new_parent.children << self unless new_parent.nil?
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Node is not a child' if child_node.parent.nil?
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    return nil if @children.empty?

    @children.each do |child|
      found_node = child.dfs(target_value)
      return found_node if found_node
    end

    nil
  end

  def bfs(target_value)
    queue = []
    queue.push(self)

    until queue.empty?
      current_node = queue.shift

      return current_node if current_node.value == target_value
      
      queue += current_node.children
    end

    nil
  end

  def trace_path_back
    current_node = self
    path = []
    until current_node.parent.nil?
      path << current_node.value
      current_node = current_node.parent
    end

    path << current_node.value

    path
  end


end
