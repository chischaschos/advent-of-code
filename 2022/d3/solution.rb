require 'debug'
require 'ostruct'

# input = <<~INPUT
#   vJrwpWtwJgWrhcsFMMfFFhFp
#   jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#   PmmdzqPrVvPwwTWBwg
#   wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#   ttgJtRGJQctTZtZT
#   CrZsJsPPZsGzwwsLwLmpwMDw
# INPUT

input = IO.read('input.txt')

priorities = ('a'..'z').to_a + ('A'..'Z').to_a

common_items_per_group = input.split("\n").each_slice(3).map do |r1, r2, r3|
  set = Hash.new { |h, k| h[k] = false }
  union_r1_r2 = Hash.new { |h, k| h[k] = false }
  union = Hash.new { |h, k| h[k] = false }

  r1.chars.each do |i|
    set[i] = true
  end

  r2.chars.each do |i|
    union_r1_r2[i] = true if set.key?(i)
  end

  r3.chars.each do |i|
    union[i] = true if union_r1_r2.key?(i)
  end

  union.keys.first
end

common_item_priorities = common_items_per_group.map do |item|
  priorities.index(item) + 1
end.to_a

puts common_item_priorities.sum
