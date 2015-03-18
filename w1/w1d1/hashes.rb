class MyHashSet
  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.keys.include?(el)
  end

  def delete(el)
    @store.delete(el).nil? ? false : true
  end

  def to_a
    @store.to_a
  end

  def union(set2)
    union_set = MyHashSet.new
    @store.to_a.each do |item|
      union_set.insert(item[0])
    end
    set2.to_a.each do |item|
      union_set.insert(item[0])
    end

    union_set
  end

  def intersect(set2)
    intersect_set = MyHashSet.new
    @store.to_a.each do |item|
      intersect_set.insert(item[0]) if set2.to_a.include?(item)
    end

    intersect_set
  end

  def minus(set2)
    minus_set = MyHashSet.new
    @store.to_a.each do |item|
      minus_set.insert(item[0]) unless set2.to_a.include?(item)
    end

    minus_set
  end
end

# set = MyHashSet.new
# set.insert("blah")
# set.include?("blah")
# set.delete("blah")
# set.insert("a")
# set.insert("b")
# set2 = MyHashSet.new
# set2.insert("b")
# set2.insert("c")
# set2.to_a
# p set.union(set2)
# p set.intersect(set2)
# p set.minus(set2)
