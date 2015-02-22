class WordChainer
  def initialize(dictname = 'dictionary.txt')
    @dict = Set.new(File.readlines(dictname).map { |word| word.chomp })
  end

  def run(starting_word, ending_word)
    raise "you suck!" if starting_word.length != ending_word.length
    initialize_run(starting_word)

    loop do
      current_word = @queue.shift
      if current_word == ending_word
        render(calculate_chain(starting_word, current_word))
        break
      end
      discover(find_close_words(current_word), current_word)
    end
  end

  def calculate_chain(starting_word, current_word)
    chain = []
    added_word = current_word
    until added_word == starting_word
      chain << added_word
      added_word = @found_words[added_word]
    end

    chain.reverse
  end

  def render(chain)
    puts chain
  end

  def initialize_run(starting_word)
    @queue = [starting_word]
    @found_words = {}
    @trimmed_dict = @dict.select { |word| word.length == starting_word.length }
    @trimmed_dict.delete(starting_word)
  end

  def discover(words, current_word)
    words.each do |word|
      @queue << word
      @found_words[word] = current_word
    end
  end

  def find_close_words(word)
    close_words = []
    word.length.times do |i|
      ("a".."z").each do |letter|
        new_word = word[0...i] + letter + word[i + 1..-1]
        if @trimmed_dict.include?(new_word)
          close_words << new_word
          @trimmed_dict.delete(new_word)
        end
      end
    end

    close_words
  end
end
