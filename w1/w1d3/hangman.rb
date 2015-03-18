require 'byebug'

class Hangman
  def initialize(guesser, checker)
    @guessing_player = guesser
    @checking_player = checker
    @guesses = 0
  end

  def play
    hangman_word = @checking_player.pick_secret_word
    puts 'you have 10 guesses'

    start_game(hangman_word)

    print_outcome(hangman_word)

    @guesses = 0
  end

  def start_game(hangman_word)
    while @guesses < 10
      puts "Secret word: #{hangman_word}"
      letter = @guessing_player.guess(hangman_word)
      new_word = @checking_player.check_guess(letter)
      if new_word == hangman_word
        @guesses += 1
      else
        hangman_word = new_word
      end

      break if won?
    end
  end

  def print_outcome(hangman_word)
    if hangman_word.include?('_')
      puts 'You lost!'
    else
      puts "You guessed the word \"#{hangman_word}\"!"
    end
  end

  def won?
    !hangman_word.include?('_')
  end
end

class HumanPlayer
  def initialize
    @hangman_word = ''
  end

  def pick_secret_word
    print 'How long is the word? '

    @hangman_word = '_' * gets.chomp.to_i
  end

  def guess(_)
    print 'Guess a letter: '
    gets.chomp
  end

  def check_guess(letter)
    print 'press enter if letter not found or enter the '
    puts 'position(s) of the letter separated by commas'
    pos = gets.chomp

    return @hangman_word if pos == ''

    pos.split(',').map(&:to_i).each do |index|
      @hangman_word[index] = letter
    end

    @hangman_word
  end
end

class ComputerPlayer
  def initialize
    @hangman_word = ''
    @secret_word = ''
    @dictionary = []
    File.foreach('dictionary.txt') do |line|
      @dictionary << line.chomp
    end
    @possible_words = @dictionary.dup
    @guessed_letters = []
    @length = 0
  end

  def pick_secret_word
    @secret_word = @dictionary.sample

    @hangman_word = '_' * @secret_word.size
  end

  def receive_secret_length(word)
    @length = word.count
  end

  def guess(word)
    trim_possible_words(word)

    guess = most_common_letter
    @guessed_letters << guess
    puts guess

    guess
  end

  def trim_possible_words(word)
    @possible_words.delete_if do |possible_word|
      possible_word.length != word.length
    end
    word.split('').each_index do |i|
      unless word[i] == '_'
        @possible_words.delete_if do |possible_word|
          possible_word[i] != word[i]
        end
      end
    end
  end

  def most_common_letter
    all_letters = ''
    @possible_words.each do |word|
      all_letters << word
    end
    guess = 'a'
    max_letter_count = 0
    ('a'..'z').to_a.each do |char|
      if max_letter_count < all_letters.count(char) &&
         !@guessed_letters.include?(char)
        max_letter_count = all_letters.count(char)
        guess = char
      end
    end

    guess
  end

  def check_guess(letter)
    @secret_word.split('').each_index do |i|
      @hangman_word[i] = letter if @secret_word[i] == letter
    end

    @hangman_word
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.count == 2
    player1 = (ARGV[0] == 'computer' ? ComputerPlayer.new : HumanPlayer.new)
    player2 = (ARGV[1] == 'computer' ? ComputerPlayer.new : HumanPlayer.new)
    h = Hangman.new(player1, player2)
    ARGV.clear
  else
    h = Hangman.new(HumanPlayer.new, ComputerPlayer.new)
  end
  h.play

  nil
end
