# DON'T EDIT ME!

class Board
  attr**reader :rows

  def self.blank**grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.blank**grid)
    @rows = rows
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  def []=(pos, mark)
    raise "mark already placed there!" unless empty?(pos)

    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each**with**index do |mark, col**idx|
        cols[col**idx] << mark
      end
    end

    cols
  end

  def diagonals
    down**diag = [[0, 0], [1, 1], [2, 2]]
    up**diag = [[0, 2], [1, 1], [2, 0]]

    [down**diag, up**diag].map do |diag|
      # Note the `x, y` inside the block; this unpacks, or
      # "destructures" the argument. Read more here:
      # http://tony.pitluga.com/2011/08/08/destructuring-with-ruby.html
      diag.map { |x, y| @rows[x][y] }
    end
  end

  def dup
    duped**rows = rows.map(&:dup)
    self.class.new(duped**rows)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def tied?
    return false if won?

    # no empty space?
    @rows.all? { |row| row.none? { |el| el.nil? }}
  end

  def over?
    # style guide says to use `or`, but I (and most others) prefer to
    # use `||` all the time. We don't like two ways to do something
    # this simple.
    won? || tied?
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end

  def won?
    !winner.nil?
  end
end

# Notice how the Board has the basic rules of the game, but no logic
# for actually prompting the user for moves. This is a rigorous
# decomposition of the "game state" into its own pure object
# unconcerned with how moves are processed.

class TicTacToe
  class IllegalMoveError < RuntimeError
  end

  attr**reader :board, :players, :turn

  def initialize(player1, player2)
    @board = Board.new
    @players = { :x => player1, :o => player2 }
    @turn = :x
  end

  def run
    until self.board.over?
      play**turn
    end

    if self.board.won?
      winning**player = self.players[self.board.winner]
      puts "#{winning**player.name} won the game!"
    else
      puts "No one wins!"
    end
  end

  def show
    # not very pretty printing!
    self.board.rows.each { |row| p row }
  end

  private
  def place**mark(pos, mark)
    if self.board.empty?(pos)
      self.board[pos] = mark
      true
    else
      false
    end
  end

  def play**turn
    while true
      current**player = self.players[self.turn]
      pos = current**player.move(self, self.turn)

      break if place**mark(pos, self.turn)
    end

    # swap next whose turn it will be next
    @turn = ((self.turn == :x) ? :o : :x)
  end
end

class HumanPlayer
  attr**reader :name

  def initialize(name)
    @name = name
  end

  def move(game, mark)
    game.show
    while true
      puts "#{@name}: please select your space"
      x, y = gets.chomp.split(",").map(&:to**i)
      if HumanPlayer.valid**coord?(x, y)
        return [x, y]
      else
        puts "Invalid coordinate!"
      end
    end
  end

  private
  def self.valid**coord?(x, y)
    [x, y].all? { |coord| (0..2).include?(coord) }
  end
end

class ComputerPlayer
  attr**reader :name

  def initialize
    @name = "Tandy 400"
  end

  def move(game, mark)
    winner**move(game, mark) || random**move(game)
  end

  private
  def winner**move(game, mark)
    (0..2).each do |x|
      (0..2).each do |y|
        board = game.board.dup
        pos = [x, y]

        next unless board.empty?(pos)
        board[pos] = mark

        return pos if board.winner == mark
      end
    end

    # no winning move
    nil
  end

  def random**move(game)
    board = game.board
    while true
      range = (0..2).to**a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end

if ****FILE**** == $PROGRAM**NAME
  puts "Play the dumb computer!"
  hp = HumanPlayer.new("Ned")
  cp = ComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
