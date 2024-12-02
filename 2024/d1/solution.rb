require 'debug'

list = IO.read('input.txt')

l1 = []
l2 = []

list.split("\n").each do |line|
  n1, n2 = line.split.map(&:to_i)

  l1 << n1
  l2 << n2
end

l1.sort!
l2.sort!

puts (l1.zip(l2).map do |pair|
  (pair[0] - pair[1]).abs
end).sum
