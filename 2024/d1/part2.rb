# - Calculate a total similarity score
# - adding up each number in the left list
#   - after multiplying it by the number of times
#   - that number appears in the right list

require 'debug'

list = IO.read('input.txt')

l1 = []
l2 = Hash.new(0)

list.split("\n").each do |line|
  n1, n2 = line.split.map(&:to_i)

  l1 << n1
  l2[n2] += 1
end

puts (l1.map do |n|
  n * l2[n]
end).sum
