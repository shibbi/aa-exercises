def arr_times_two(arr)
  arr.map { |el| el*2 }
end

#arr = [1, 2, 3, 4]
# p arr_times_two(arr)

class Array
  def my_each
    for i in 0...self.size do
      yield(self[i])
    end
    self
  end
end

# calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
# 2
# 3
# 1
# 2
# 3

p return_value # => [1, 2, 3]

def arr_median(arr)
  sorted_arr = arr.sort

  return sorted_arr[arr.size/2] if arr.count%2 == 1

  (sorted_arr[arr.size/2-1]+sorted_arr[arr.size/2])/2
end

# puts arr_median([7, 2, 5, 0, 1])
# puts arr_median([0, 0, 5, 5, 3, 5, 5, 4]) # 0 0 3 4 5 5 5 5

def concatenate(str_arr)
  str_arr.inject { |final_str, substr| final_str + substr }
end

# puts concatenate(["Yay ", "for ", "strings!"])
