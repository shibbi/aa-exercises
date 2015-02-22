require "byebug"
def factors(number)
  factors = [1]

  2.upto(number) do |factor|
    factors << factor if number % factor == 0
  end

  factors
end

def bubble_sort(arr)
  loop do
    sorted = true
    for i in (0...arr.count - 1) do
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
    break if sorted
  end

  arr
end

def substrings(str)
  substr_arr = []

  0...str.size.times do |i|
    0...(str.size - i).times do |j|
      substr_arr << str[j, i + 1]
    end
  end

  substr_arr
end

def subwords(str)
  dictionary = []
  File.foreach('dictionary.txt') do |line|
    dictionary << line.chomp
  end
  # debugger

  real_words = []

  substrings(str).each do |word|
    real_words << word if dictionary.include?(word)
  end

  real_words
end
