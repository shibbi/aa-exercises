require 'byebug'

class Array
  def my_each &prc
    self.length.times do |i|
      prc.call(self[i])
    end
  end

  def my_map &prc
    newary = []
    self.my_each do |el|
      newary << prc.call(el)
    end

    newary
  end

  def my_select &prc
    newary = []
    self.my_each do |el|
      newary << el if prc.call(el)
    end

    newary
  end

  def my_inject &prc
    result = self.first
    self[1..-1].my_each do |el|
      result = prc.call(result, el)
    end

    result
  end


  def my_sort! &prc
    my_sort_helper(self, prc)
  end

  def my_sort &prc
    self.dup.my_sort!(&prc)
  end

  def my_sort_helper(arr, prc)
    return arr if arr.count < 2

    pivot = arr.pop
    left, right = [], []
    arr.each do |el|
      if prc.call(el, pivot) == -1
        left << el
      else
        right << el
      end
    end

    my_sort_helper(left, prc) + [pivot] + my_sort_helper(right, prc)
  end
end

def eval_block(*args, &prc)
  if prc.nil?
    puts "NO BLOCK GIVEN!"
    return
  end
  prc.call(*args)
end
