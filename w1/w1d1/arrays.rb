# array exercises
require 'byebug'
class Array
  def my_uniq
    new_arr = []
    self.each do |element|
      new_arr << element unless new_arr.include?(element)
    end

    new_arr
  end

  def two_sum
    zero_sums = []
    (0...self.size).each do |i|
      (i + 1...self.size).each do |j|
        if i != j && (self[i] + self[j] == 0)
          zero_sums << [i, j]
        end
      end
    end
    # no real need to sort because the way the loops run
    # the sum pairs should already be sorted
    zero_sums.sort do |x, y|
      x[0] == y[0] ? x[1] <=> y[1] : x[0] <=> y[0]
    end
  end
end

# p [1, 2, -1, -2, 0, 5].two_sum

def my_transpose(matrix)
  new_matrix = []
  matrix.each_index do |row_index|
    new_matrix[row_index] = []
    for col_index in 0...matrix.count do
      new_matrix[row_index][col_index] = matrix[col_index][row_index]
    end
  end

  new_matrix
end

def stock_picker(prices)
  most_profitable = []
  profit = 0

  (0...prices.count).each do |day1|
    (day1 + 1...prices.count).each do |day2|
      diff = prices[day2]-prices[day1]
      if diff > profit
        profit = diff
        most_profitable = [day1, day2]
      end
    end
  end
  most_profitable
end

# p stock_picker([100, 10, 40])

# should modulize every 10 lines of code into methods
def towers_of_hanoi(height)
  count = 0
  minimum_moves = 2**height-1
  towers = [[], [], []]
  for i in 1..height do
    towers[0].insert(0, i)
  end
  winning = Array.new(towers[0])

  while true
    from = get_pile(1, towers)
    to = get_pile(2, towers)
    if towers[to].empty? || towers[from].last < towers[to].last
      towers[to] << towers[from].pop
      p towers
      count+=1
    else
      puts "Invalid move."
    end

    if towers[2]==winning
      puts "YOU WON YAY! You used #{count} moves."
      if count > minimum_moves
        puts "But you could have done it in #{minimum_moves}."
      else
        puts "You rock! You did it in the least number of moves needed."
      end
      break
    end
  end
end

def get_pile(option, towers)
  if option == 1
    puts "What pile do you want to select from?"
    choice = gets.chomp.to_i-1
    while choice < 0 || choice > towers.count-1 || towers[choice].empty?
      puts "Invalid selection. Select another pile."
      choice = gets.chomp.to_i-1
    end
  else
    puts "What pile do you want to put the disc in?"
    choice = gets.chomp.to_i-1
    while choice < 0 || choice > towers.count-1
      puts "Invalid selection. Select another pile."
      choice = gets.chomp.to_i-1
    end
  end
  choice
end
