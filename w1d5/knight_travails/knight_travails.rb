require_relative '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder

  MOVES_DIR = [[2, -1], [2, 1], [-2, -1], [-2, 1],
              [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze
  
  def self.valid_moves(pos)
    valid_moves = []
    KnightPathFinder::MOVES_DIR.each do |dpos|
      dy, dx = dpos
      dy += pos[0]
      dx += pos[1]
      valid_moves << [dy, dx] if KnightPathFinder.within_bounds?(dy, dx)
    end
    valid_moves
  end

  def self.within_bounds?(y, x)
    y > -1 && y < 8 && x > -1 && x < 8
  end

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = {start_pos=>true}
    build_move_tree
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions[move] }
    new_moves.each { |move| @considered_positions[move] = true }
    new_moves
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      current = queue.shift
      moves = new_move_positions(current.value)
      moves.each do |move| 
        new_node = PolyTreeNode.new(move)
        current.add_child(new_node)
        queue << new_node
      end
    end
  end

  def find_path(end_pos)
    leaf = @root_node.dfs(end_pos)
    trace_path_back(leaf)
  end

  def trace_path_back(node)
    path = []
    until node.nil? 
      path << node.value
      node = node.parent
    end
    path.reverse
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]