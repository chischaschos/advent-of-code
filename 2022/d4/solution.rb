# frozen_string_literal: true

require 'debug'
require 'ostruct'

# input = <<~INPUT
#   2-4,6-8
#   2-3,4-5
#   5-7,7-9
#   2-8,3-7
#   6-6,4-6
#   2-6,4-8
# INPUT

input = IO.read('input.txt')

overlap_results = input.split("\n").map do |assignment|
  a1, a2 = assignment.split(',')

  b1, e1 = a1.split('-').map(&:to_i)
  b2, e2 = a2.split('-').map(&:to_i)

  b1 >= b2 && e1 <= e2 || b2 >= b1 && e2 <= e1
end

puts overlap_results.count { |overlap_result| overlap_result }
