require 'byebug'

class Code
  POSSIBLE_PEGS = %w(R G B Y O P)

  attr_accessor :pegs

  def initialize
    @pegs = []
  end

  def self.random
    code = self.new
    4.times { code.pegs << POSSIBLE_PEGS.sample }

    code
  end

  def self.parse(input)
    code = self.new
    code.pegs = input.split('')

    code
  end

  def compare(other_code)
    matches = exact_matches(other_code)

    [matches.size, near_matches(matches, other_code)]
  end

  def exact_matches(other_code)
    matches = []
    other_code.pegs.each_index do |i|
      matches << i if other_code.pegs[i] == @pegs[i]
    end

    matches
  end

  def near_matches(matches, other_code)
    pegs_left, other_pegs_left = [], []
    @pegs.each_index do |i|
      unless matches.include?(i)
        pegs_left << @pegs[i]
        other_pegs_left << other_code.pegs[i]
      end
    end

    near_matched_indexes = []
    pegs_left.each_index do |i|
      other_pegs_left.each_index do |j|
        if pegs_left[i] == other_pegs_left[j]
          unless near_matched_indexes.include?(j)
            near_matched_indexes << j
          end
        end
      end
    end

    near_matched_indexes.size
  end
end

class Game
  def initialize
    @correct_code = Code.random
    @turn = 10
  end

  def play
    puts @correct_code.pegs

    guess_loop

    if @turn > 0
      puts "you win"
    else
      puts "out of turns, you lose"
    end
  end

  def guess_loop
    while @turn > 0
      guess = Code.parse(gets.chomp.upcase)
      result = @correct_code.compare(guess)
      puts "#{result[0]} exact matches, #{result[1]} near matches"
      break if result[0] == 4
      @turn -= 1
    end
  end
end
