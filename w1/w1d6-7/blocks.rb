class Array
  def my_each
    0.upto(length - 1) { |index| yield(self[index]) }
  end

  def my_select
    [].tap do |new_arr|
      my_each { |el| new_arr << el if yield(el) }
    end
  end

  def my_map
    [].tap do |new_arr|
      my_each { |el| new_arr << yield(el) }
    end
  end
end

def eval_block(*args, &prc)
  return 'NO BLOCK GIVEN' unless block_given?
  prc.call(*args)
end

# # Example calls to eval_block
# eval_block('Kerry', 'Washington', 23) do |fname, lname, score|
#   puts "#{lname}, #{fname} won #{score} votes."
# end
# # Washington, Kerry won 23 votes.
# # => nil
#
# p eval_block(1, 2, 3, 4, 5) { |*args| args.inject(:+) }
# # => 15
#
# p eval_block(1, 2, 3)
# # => "NO BLOCK GIVEN"
