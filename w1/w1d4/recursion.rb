def range_recursive(start_number,end_number)
  return [] if end_number < start_number

  range_recursive(start_number, end_number - 1) + [end_number]
end

def range_iterative(start_num, end_num)
  result_array = []

  (start_num..end_num).each { |num| result_array << num }

  result_array
end

def exponent_one(base, exp)
  return 1 if exp == 0

  exponent_one(base, exp - 1) * base
end

def exponent_two(base, exp)
  case
  when exp == 0
    return base
  when exp == 1
    return base
  when exp.even?
    operand = exponent_two(base, exp / 2)
    return operand * operand
  when exp.odd?
    operand = exponent_two(base, (exp - 1) / 2)
    return operand * operand * base
  end
end

class Array
  def deep_dup
    result = []
    self.each do |el|
      if el.is_a? Array
        result << el.deep_dup
      else
        result << el
      end
    end

    result
  end
end

def fib(n)
  case n
  when 1
    return [1]
  when 2
    return [1,1]
  else
    return fib(n - 1) + [fib(n - 1)[n - 2] + fib(n - 1)[n - 3]]
  end
end

def bsearch(array, target)
  if array.count < 2
    return 0 if array[0] == target
    return nil
  end

  pivot_index = array.count / 2

  right_found = bsearch(array[pivot_index..-1], target)
  right_found += pivot_index if right_found

  bsearch(array[0...pivot_index], target) || right_found
end


def make_change_one(amount, coins = [25, 10, 5, 1])
  change = []

  coins.each do |coin|
    if amount >= coin
      change = [coin] * (amount / coin) + make_change_one(amount % coin, coins)
      break
    end
  end

  change
end

def make_change_two(amount, coins = [25, 10, 5, 1])
  change = []

  coins.each do |coin|
    if amount >= coin
      change = [coin] + make_change_one(amount - coin, coins)
      break
    end
  end

  change
end

def make_change_awesome(amount, coins = [25,10,5,1])
  change = []

  coins.each_with_index do |coin, i|
    if amount >= coin
      change << [coin] + make_change_awesome(amount - coin, coins.drop(i))
    end
  end

  change.min_by { |coin_set| coin_set.length } || change
end

def merge_sort(array)
  return array if array.count < 2

  left_sorted_array = merge_sort(array[0...array.count / 2])
  right_sorted_array = merge_sort(array[array.count / 2..-1])

  merge(left_sorted_array, right_sorted_array)
end

def merge(left_array, right_array)
  sorted_array = []
  until left_array.empty? || right_array.empty?
    if left_array.first < right_array.first
      sorted_array << left_array.shift
    else
      sorted_array << right_array.shift
    end
  end
  sorted_array += [left_array, right_array].max_by { |ary| ary.count }

  sorted_array
end

def subsets(array)
  return [array] if array.empty?
  new_element = array.pop

  result = []
  subsets(array).each do |subset|
    result << subset
    result << subset + [new_element]
  end

  result
end
