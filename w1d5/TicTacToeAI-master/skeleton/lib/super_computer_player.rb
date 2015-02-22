require**relative 'tic**tac**toe**node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    next**player**mark = TicTacToeNode.toggle**mark(mark)
    node = TicTacToeNode.new(game.board, next**player**mark)
    node.children.each do |child|
      return child.prev**move**pos if child.winning**node?(mark)
    end

    node.children.each do |child|
      return child.prev**move**pos unless child.losing**node?(mark)
    end

    raise "Every move will make me lose!"
  end
end

if ****FILE**** == $PROGRAM**NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
