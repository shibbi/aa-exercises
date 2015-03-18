require 'yaml'

class Tile
  attr_accessor :state, :mine

  def initialize(pos)
    @state = '*'
    @mine = false
    @location = pos
  end

  def reveal(board)
    bomb_count = neighbor_bomb_count(board)
    if bomb_count > 0
      @state = "#{bomb_count}"
    else
      @state = '_' unless @mine
    end

    @mine
  end

  #done
  def neighbors(board)
    neighbor_tiles = []
    offsets = [[-1, -1], [-1, 0], [-1, 1], [0, -1],
               [0, 1], [1, -1], [1, 0], [1, 1]]
    offsets.each do |offset|
      actual_pos = [offset[0] + self.location[0], offset[1] + self.location[1]]
      if Tile.valid_pos?(board, actual_pos)
        neighbor_tiles << board.tiles[actual_pos[0]][actual_pos[1]]
      end
    end

    neighbor_tiles
  end

  def self.valid_pos?(board, pos)
    pos.min >= 0 && pos.max < board.length
  end

  #done
  def neighbor_bomb_count(board)
    neighbors(board).count do |neighbor|
      neighbor.mine
    end
  end
end

class Board
  attr_reader :length, :tiles

  def initialize(length)
    @length = length
    @tiles = Array.new(@length) { Array.new(@length) }
    @tiles.each_index do |i|
      tiles[i].each_index do |j|
        @tiles[i][j] = Tile.new([i, j])
      end
    end
  end

  def display
    @tiles.each do |row|
      print '|'
      row.each do |tile|
        print tile.state + '|'
      end
      puts ''
    end

    nil
  end

  def flag_tile(pos)
    x, y = pos
    current_tile = @tiles[x][y]

    if current_tile.state == 'F' || current_tile.state == '_'
      puts "Cannot flag tile."
    else
      current_tile.state = 'F'
    end

    false
  end

  def reveal_tile(pos, checked = [])
    x, y = pos
    current_tile = @tiles[x][y]
    if current_tile.state == 'F'
      puts "Cannot reveal flagged tile. Unflag first."
      return false
    end

    bomb = current_tile.reveal(self)
    checked << current_tile

    if current_tile.neighbor_bomb_count(self) == 0
      current_tile.neighbors(self).each do |neighbor|
        next if checked.include?(neighbor)
        reveal_tile(neighbor.location, checked)
      end
    end

    bomb
  end

  def unflag_tile(pos)
    x, y = pos
    current_tile = @tiles[x][y]

    if current_tile.state != 'F'
      puts "Cannot unflag tile."
    else
      current_tile.state = '*'
    end

    false
  end

  def won?
    # change it so you don't have to flag all bombs
    leftovers = 0
    all_flipped = true
    @tiles.each do |row|
      leftovers += row.count { |tile| tile.state == 'F' || tile.state == '*' }
    end

    leftovers == 10
  end

  def show_mines
    @tiles.each do |row|
      row.each do |tile|
        tile.state = "o" if tile.mine
      end
    end
  end
end

class Minesweeper
  BOARD_SIZES = {
    easy: 9,
    medium: 16,
    hard: 32
  }

  TOTAL_BOMBS = {
    easy: 10,
    medium: 40,
    hard: 99
  }

  attr_accessor :board

  def initialize(option = :easy)
    @board = Board.new(BOARD_SIZES[option])
    set_mines
  end

  def play
    mine = false
    until mine || @board.won?
      @board.display
      case choice
      when 'f'
        mine = @board.flag_tile(pos)
      when 'r'
        mine = @board.reveal_tile(pos)
      when 'u'
        mine = @board.unflag_tile(pos)
      when 's'
        save
      when 'q'
        return nil
      end
    end

    if @board.won?
      puts "YOU HAVE WON YAY"
    else
      puts "YOU LOST SADFACE"
      @board.show_mines
    end

    @board.display
  end

  def set_mines(option = :easy)
    mine_positions = []
    while mine_positions.length < TOTAL_BOMBS[option]
      i, j = rand(BOARD_SIZES[option]), rand(BOARD_SIZES[option])
      mine_positions << [i, j] unless mine_positions.include?([i, j])
    end

    mine_positions.each do |pos|
      x, y = pos
      @board.tiles[x][y].mine = true
    end
  end

  def choice
    choice = "dummy"
    valid_choices = %w(f q r s u)

    until valid_choices.include?(choice)
      puts "Do you want to flag (f) or reveal (r) or unflag (u) a tile? "
      puts "You can also save (s) or quit (q) the game"
      choice = gets.chomp
      unless valid_choices.include?(choice)
        puts "Invalid action. Please type flag (f) or reveal (r) or unflag (u)."
      end
    end

    choice.downcase[0]
  end

  def pos
    pos = [-1, -1]

    until Tile.valid_pos?(@board, pos)
      print 'Which tile? '
      pos = gets.chomp.split(", ").map(&:to_i)
      unless Tile.valid_pos?(@board, pos)
        puts "Invalid tile. Pick again."
      end
    end

    pos
  end

  def save
    print "What file do you want to save to? Press enter to save to default."
    input = gets.chomp
    input == "" ? filename = "minesweeper.yml" : filename = "#{input}.yml"

    File.open(filename, "w") do |f|
      f.puts(self.to_yaml)
    end
  end

  def self.load(filename = "minesweeper.yml")
    m = YAML.load_file(filename)
    m.play
  end
end
