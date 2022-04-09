class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(val)
    @value = val
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?

    @parent = new_parent
    new_parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self unless child_node.parent == self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil 
    else
      raise "Child_node doesn't belong to this parent."
    end
  end

  def inspect
    {'value' => @value, 'parent_value' => (@parent.nil? ? 'nil' : @parent.value)}.inspect
  end

  def dfs(target_value)
    return self if target_value == self.value

    self.children.each do |child|
      target = child.dfs(target_value)
      return target unless target.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      target = queue.shift
      return target if target.value == target_value
      
      target.children.each do |child|
        queue << child
      end
    end
    nil
  end
end