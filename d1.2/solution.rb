require 'debug'
require './pqueue'
require 'ostruct'

# Using https://github.com/rubyworks/pqueue
# Lazy enough to build my own priority queue
inventory = IO.read('input.txt')

index = 1

pq = PQueue.new { |a, b| a.total > b.total }

inventory.split(/\n\n/).to_enum.map do |match|
  total = match.split.map(&:to_i).sum

  pq.push(OpenStruct.new(total:, index:))

  index += 1
end

puts pq.pop.total + pq.pop.total + pq.pop.total

# Find top 3, how many are they carrying?
