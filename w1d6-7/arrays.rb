require 'byebug'

class Array
  def my_uniq
    [].tap do |unique_arr|
      each do |el|
        unique_arr << el unless unique_arr.include?(el)
      end
    end
  end

  def two_sum
    [].tap do |zero_sums|
      each_index do |first_index|
        each_index do |second_index|
          next if first_index == second_index
          pair = [first_index, second_index].sort
          pair_sum = self[first_index] + self[second_index]
          zero_sums << pair if pair_sum == 0
        end
      end
    end.uniq
  end
end

def my_transpose(matrix)
  return [] if matrix.empty?
  [].tap do |new_matrix|
    matrix.first.each_index do |row|
      new_matrix << Array.new(matrix.count)
      new_matrix[row].each_index do |col|
        new_matrix[row][col] = matrix[col][row]
      end
    end
  end
end

def stock_picker(prices)
  profit, most_profitable = 0, []
  0.upto(prices.count - 1) do |buy_day|
    (buy_day + 1).upto(prices.count - 1) do |sell_day|
      if prices[sell_day] - prices[buy_day] > profit
        profit = prices[sell_day] - prices[buy_day]
        most_profitable = [buy_day, sell_day]
      end
    end
  end

  most_profitable
end

def towers_of_hanoi(max_stack_size = 3)
  stacks = [[], [], []]
  stacks[0] = (1..max_stack_size).to_a.reverse

  moves = 0
  loop do
    from, to = prompt
    unless valid_move?(stacks, from, to)
      puts 'Invalid move!!!'
      next
    end
    stacks[to - 1] << stacks[from - 1].pop
    display(stacks, max_stack_size)
    moves += 1

    break if won?(stacks)
  end

  puts "You've won in #{moves}!" if won?(stacks)
end

def prompt
  print 'What pile do you want to move from? '
  from = gets.chomp.to_i
  print 'What pile do you want to move to? '
  to = gets.chomp.to_i

  [from, to]
end

def valid_move?(stacks, from, to)
  return false if from < 1 || from > 3 || to < 1 || to > 3
  return false if stacks[from - 1].empty?
  return true if stacks[to - 1].empty?
  return false if stacks[from - 1].last > stacks[to - 1].last
  true
end

def display(stacks, max_stack_size)
  offset = ''
  stacks.each_with_index do |stack, stack_num|
    # puts offset + "Stack #{stack_num + 1}"
    stack.reverse.each do |disc|
      print offset + '|' + '-' * disc + ' ' * (max_stack_size - disc) + '|'
      puts ''
    end
    offset += ' ' * (max_stack_size + 2)
  end
end

def won?(stacks)
  stacks.any? { |stack| stack == [3, 2, 1] }
end
