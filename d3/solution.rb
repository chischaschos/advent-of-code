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

common_items = input.split("\n").map do |rucksack|
  c1, c2 = rucksack[0..rucksack.length/2-1], rucksack[rucksack.length/2..-1]

  binding.break if c1.length != c2.length

  c1.chars.find do |item|
    c2.index(item)
  end
end

common_item_priorities = common_items.map do |item|
  priorities.index(item) + 1
end.to_a

puts common_item_priorities.sum
