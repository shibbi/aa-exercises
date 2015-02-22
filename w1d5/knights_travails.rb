require 'byebug'

load '00_tree_node.rb'

class KnightPathFinder
  # attr_reader :visited_positions

  def initialize(pos)
    @start_pos = pos
    @visited_positions = [@start_pos]
    build_move_tree
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@start_pos)
    queue = [@root_node]

    until queue.empty?
      parent_node = queue.shift

      next_pos = new_move_positions(parent_node.value)
      next_pos.each do |pos|
        child_node = PolyTreeNode.new(pos)
        parent_node.add_child(child_node)
        queue.push(child_node)
      end
    end
  end

  def new_move_positions(pos)
    new_move_positions = KnightPathFinder.valid_moves(pos).select do |possible_pos|
      !@visited_positions.include?(possible_pos)
    end
    @visited_positions += new_move_positions

    new_move_positions
  end

  def self.valid_moves(pos)
    valid_moves = []

    valid_moves << [pos[0] - 2, pos[1] - 1]
    valid_moves << [pos[0] - 2, pos[1] + 1]
    valid_moves << [pos[0] + 2, pos[1] - 1]
    valid_moves << [pos[0] + 2, pos[1] + 1]

    valid_moves << [pos[0] - 1, pos[1] - 2]
    valid_moves << [pos[0] - 1, pos[1] + 2]
    valid_moves << [pos[0] + 1, pos[1] - 2]
    valid_moves << [pos[0] + 1, pos[1] + 2]

    valid_moves.select { |move| KnightPathFinder.valid_move(move) }
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)

    end_node.trace_path_back.reverse
  end

  private

    def self.valid_move(pos)
      pos.min >= 0 && pos.max <= 7
    end

end

# if __FILE__ = $PROGRAM_NAME
#   if ARGV.empty
#     print "Where should the Knight start? Enter coordinates separated by commas"
#     start_pos = gets.chomp.split(',').map { |pos| pos.strip.to_i }
#     start_kpf(gets.chomp)
#   else
#     start_kpf(ARGV)
#   end
#
#   def start_kpf(pos)
#     start_pos = pos.split(',').map { |pos| pos.strip.to_i }
#     kpf = KnightPathFinder.new(start_pos)
#
#   end
# end
