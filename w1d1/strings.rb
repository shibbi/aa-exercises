# string exercises
def num_to_s(num, base)
  num_str_hash = { 0 => '0', 1 => '1', 2 => '2', 3 => '3',
                   4 => '4', 5 => '5', 6 => '6', 7 => '7',
                   8 => '8', 9 => '9', 10 => 'A', 11 => 'B',
                   12 => 'C', 13 => 'D', 14 => 'E', 15 => 'F'}
  digits_reversed = []
  while num > 0
    digits_reversed << num % base
    num /= base
  end

  digits_reversed.reverse.join('')
end

# puts num_to_s(243, 10)
# puts num_to_s(243, 2)

def caesar_cipher(str, num)
  new_str = ''
  str.each_char do |char|
    new_ord = char.ord + num
    new_ord += 26 while new_ord < 97
    new_ord -= 26 while new_ord > 122
    new_str << new_ord.chr
  end

  new_str
end

# puts caesar_cipher("hello", 3)
