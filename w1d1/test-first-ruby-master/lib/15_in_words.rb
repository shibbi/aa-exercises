# require 'byebug'

class Fixnum
  WORDS = {0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three',
           4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven',
           8 => 'eight', 9 => 'nine', 10 => 'ten', 11 => 'eleven',
           12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
           15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen',
           18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
           30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty',
           70 => 'seventy', 80 => 'eighty', 90 => 'ninety',
           100 => 'hundred', 1000 => 'thousand', 1000000 => 'million',
           1000000000 => 'billion', 1000000000000 => 'trillion'}

  def in_words

    new_word = ''
    if self < 100
      new_word = ones_and_tens(self)
    elsif self < 1000
      new_word = hundreds(self)
    elsif self < 1000000
      new_word = thousands(self)
    end
  end

  private
    def ones_and_tens(num)
      return WORDS[num] if num < 20
      final_word = WORDS[num / 10 * 10]
      remainder = num % 10
      final_word << (' ' + WORDS[remainder]) if remainder > 0
      # puts final_word
      final_word
    end

    def hundreds(num)
      final_word = ones_and_tens(num / 100) + ' hundred'
      remainder = num % 100
      final_word << (' ' + ones_and_tens(remainder)) if remainder > 0
      # puts final_word
      final_word
    end

    def thousands(num)
      final_word = ones_and_tens(num / 1000) + ' thousand'
      remainder = num % 1000
      final_word << (' ' + hundreds(remainder)) if remainder > 0
      final_word
    end
end
