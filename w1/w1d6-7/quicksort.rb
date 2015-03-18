class Array
  def quicksort
    return self if count < 2

    pivot_index = rand(count)
    smaller, larger = [], []
    each_with_index do |el, index|
      next if index == pivot_index
      el < self[pivot_index] ? smaller << el : larger << el
    end

    smaller.quicksort + [self[pivot_index]] + larger.quicksort
  end
end
