require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    next_player_mark = TicTacToeNode.toggle_mark(mark)
    node = TicTacToeNode.new(game.board, next_player_mark)
    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    node.children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "Every move will make me lose!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
