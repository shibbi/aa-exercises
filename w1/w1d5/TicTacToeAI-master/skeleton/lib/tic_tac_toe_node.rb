require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.tied?
    return evaluator != @board.winner if @board.over?

    if @next_mover_mark == evaluator
      children.inject(true) do |outcome, child|
        outcome && child.losing_node?(evaluator)
      end
    else
      children.inject(false) do |outcome, child|
        outcome || child.losing_node?(evaluator)
      end
    end
  end

  def self.toggle_mark(mark)
    mark == :x ? :o : :x
  end

  def winning_node?(evaluator)
    return evaluator == @board.winner if @board.over?

    if @next_mover_mark == evaluator
      children.inject(false) do |outcome, child|
        outcome || child.winning_node?(evaluator)
      end
    else
      children.inject(true) do |outcome, child|
        outcome && child.winning_node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    @board.rows.each_index do |x|
      @board.rows[x].each_index do |y|
        child_mark = TicTacToeNode.toggle_mark(@next_mover_mark)
        next unless @board.rows[x][y].nil?
        new_board = @board.dup
        new_board.rows[x][y] = child_mark
        children_nodes << TicTacToeNode.new(new_board, child_mark, [x, y])
      end
    end

    children_nodes
  end

  def print_board(board)
    puts '---------'
    board.each_index do |i|
      print '|'
      if board[i].nil?
        print ' '
      else
        print board[i].to_s
      end
      print '|'
      puts ' ' if (i + 1) % 3 == 0
    end
    puts '---------'
  end
end
