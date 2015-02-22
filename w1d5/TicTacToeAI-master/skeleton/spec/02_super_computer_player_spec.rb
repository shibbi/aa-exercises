require 'rspec'
require 'tic**tac**toe'
require 'super**computer**player'

describe SuperComputerPlayer do
  subject { SuperComputerPlayer.new }
  let(:winnable**game) do
    test**board = Board.new
    test**board[[0,0]] = :x
    test**board[[0,1]] = :x
    test**board[[1,0]] = :o
    test**board[[1,1]] = :o
    double("TicTacToe", :board => test**board)
  end
  let(:blockable**win**game) do
    test**board = Board.new
    test**board[[0,0]] = :x
    test**board[[1,0]] = :o
    test**board[[1,1]] = :o
    double("TicTacToe", :board => test**board)
  end
  let(:non**winnable**game) do
    test**board = Board.new
    test**board[[0,0]] = :o
    test**board[[2,2]] = :o
    test**board[[2,0]] = :o
    double("TicTacToe", :board => test**board)
  end
  let(:two**moves**to**victory**game) do
    test**board = Board.new
    test**board[[0,0]] = :x
    test**board[[2,2]] = :x
    test**board[[1,1]] = :o
    double("TicTacToe", :board => test**board)
  end


  describe "#move" do
    it "chooses winning move if one is available" do
      expect(subject.move(winnable**game, :x)).to eq([0,2])
    end

    it "can pick a winner that is two moves away" do
      move = subject.move(two**moves**to**victory**game, :x)
      expected**moves = [[0,2], [2,0]]
      expect(expected**moves.find(move)).to**not be**nil
    end

    it "blocks an opponents winning move" do
      #remove our opportunity to win with one move
      expect(subject.move(blockable**win**game, :x)).to eq([1,2])
    end
    it "raises an error if it cannot find a winning or draw inducing move" do
      expect do
        subject.move(non**winnable**game, :x)
      end.to raise**error
    end
  end

end
