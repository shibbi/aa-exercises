require 'byebug'
class Student
  attr_reader :courses

  def initialize(fname, lname)
    @lname = lname
    @fname = fname
    @courses = []
  end

  def name
    @fname + " " + @lname
  end

  def enroll(crs)
    if has_conflict?(crs)
      puts "This class conflicts with an existing class, dummy"
    # elsif @courses.include?(crs)
    #   puts "You can't enroll in the same course twice, stupid"
    else
      @courses << crs
      crs.add_student(self)
    end
  end

  def course_load
    credits_hash = {}
    @courses.each do |course|
      if credits_hash.has_key?(course.dept)
        credits_hash[course.dept] += course.credits
      else
        credits_hash[course.dept] = course.credits
      end
    end

    credits_hash
  end

  def has_conflict?(course)
    conflict = false
    @courses.each do |curr_course|
      conflict = curr_course.conflicts_with?(course)
    end

    conflict
  end
end

class Course
  attr_reader :dept, :credits, :students, :days_met, :time_block

  def initialize(name, dept, credits, days_met, time_block)
    @name = name
    @dept = dept
    @credits = credits
    @days_met = days_met
    @time_block = time_block
    @students = []
  end

  def add_student(student)
    @students << student
  end

  def conflicts_with?(another_course)
    conflict = false
    @days_met.each do |day|
      if another_course.days_met.include?(day) &&
         @time_block == another_course.time_block
        conflict = true
      end
    end

    conflict
  end
end

s1 = Student.new("A", "B")
s2 = Student.new("C", "D")
c1 = Course.new("C", "Test", 12, [:mon, :tues, :wed], 2)
c2 = Course.new("D", "Test 2", 45, [:tues, :fri], 2)
c3 = Course.new("E", "Test", 10, [:thurs], 2)

class TicTacToe
  class Board
    def initialize
      # 0 = empty, 1 = x, -1 = o
      @board = [[0, 0, 0],
                [0, 0, 0],
                [0, 0, 0]]
      @winner = nil
    end

    def won?
      check_rows || check_columns || check_diagonals
    end

    def winner
      winner
    end

    def empty?(pos)
      @board[pos[0], pos[1]] == 0
    end

    def place_mark(pos, mark)
      @board[pos[0], pos[1]] = mark
    end

    private
      def check_rows(b = @board)
        win = false
        @board.each do |row|
          if row[0] == row[1] && row[1] == row[2]
            win = true
            winner = row[0]
          end
        end

        win
      end

      def check_columns
        check_rows(@board.transpose)
      end

      def check_diagonals
        win_x = [1, 1, 1]
        win_o = [2, 2, 2]
        if [@board[0][0], @board[1][1], @board[2][2]] == win_x ||
           [@board[2][0], @board[1][1], @board[0][2]] == win_x
          winner = 1
        elsif [@board[0][0], @board[1][1], @board[2][2]] == win_o ||
              [@board[2][0], @board[1][1], @board[0][2]] == win_o
          winner = -1
        end
      end
  end

  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @board = Board.new
    end

    def play
      current_player = @player1.type == "human" ? @player1 : @player2
      mark = 1 # x mark

      loop do
        debugger
        pos = current_player.move(@board)
        @board.place_mark(pos, mark)

        break if @board.won?

        current_player = @player1 if current_player == @player2
        current_player = @player2 if current_player == @player1
        mark *= -1
      end

      print_board
    end

    def print_board
      @board.each do |row|
        puts row
      end
    end
  end

  class HumanPlayer
    def type
      "human"
    end

    def move(board)
      # print "Make a move: "
      # pos = gets.chomp.split(" ,")
      # until board.empty?(pos)
      #   print "That spot is taken. Pick again: "
      #   pos = gets.chomp.split(" ,")
      # end
      #
      # pos
      [0, 0]
    end
  end

  class ComputerPlayer < HumanPlayer
    def type
      "computer"
    end

    def move(board)
      # return winning_move if winning_move

      pos = [rand(2), rand(2)]
      pos = [rand(2), rand(2)] until board.empty?(pos)

      pos
    end
  end

end
