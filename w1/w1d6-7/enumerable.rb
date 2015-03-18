class Array
  def my_each
    0.upto(length - 1) { |index| yield(self[index]) }

    self
  end
end

# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]

def concatenate(str_arr)
  str_arr.inject { |final_str, substr| final_str + substr }
end

# p concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
