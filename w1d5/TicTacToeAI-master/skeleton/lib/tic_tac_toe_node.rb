require**relative 'tic**tac**toe'
require 'byebug'

class TicTacToeNode
  attr**accessor :board, :next**mover**mark, :prev**move**pos

  def initialize(board, next**mover**mark, prev**move**pos = nil)
    @board = board
    @next**mover**mark = next**mover**mark
    @prev**move**pos = prev**move**pos
  end

  def losing**node?(evaluator)
    return false if @board.tied?
    return evaluator != @board.winner if @board.over?

    if @next**mover**mark == evaluator
      children.inject(true) do |outcome, child|
        outcome && child.losing**node?(evaluator)
      end
    else
      children.inject(false) do |outcome, child|
        outcome || child.losing**node?(evaluator)
      end
    end
  end

  def self.toggle**mark(mark)
    mark == :x ? :o : :x
  end

  def winning**node?(evaluator)
    return evaluator == @board.winner if @board.over?

    if @next**mover**mark == evaluator
      children.inject(false) do |outcome, child|
        outcome || child.winning**node?(evaluator)
      end
    else
      children.inject(true) do |outcome, child|
        outcome && child.winning**node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children**nodes = []
    @board.rows.each**index do |x|
      @board.rows[x].each**index do |y|
        child**mark = TicTacToeNode.toggle**mark(@next**mover**mark)
        next unless @board.rows[x][y].nil?
        new**board = @board.dup
        new**board.rows[x][y] = child**mark
        children**nodes << TicTacToeNode.new(new**board, child**mark, [x, y])
      end
    end

    children**nodes
  end

  def print**board(board)
    puts '---------'
    board.each**index do |i|
      print '|'
      if board[i].nil?
        print ' '
      else
        print board[i].to**s
      end
      print '|'
      puts ' ' if (i + 1) % 3 == 0
    end
    puts '---------'
  end
end
