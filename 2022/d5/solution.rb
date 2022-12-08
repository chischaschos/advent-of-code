# frozen_string_literal: true

require 'debug'
require 'ostruct'

# input = <<~INPUT
#       [D]
#   [N] [C]
#   [Z] [M] [P]
#    1   2   3

#   move 1 from 2 to 1
#   move 3 from 1 to 3
#   move 2 from 2 to 1
#   move 1 from 1 to 2
# INPUT

# input = <<~INPUT
#       [D]
#   [N] [C]
#   [Z] [M] [P]
#    1   2   3

#   move 4 from 2 to 1
# INPUT

input = IO.read('input.txt')

stop_at = input.split("\n").find_index { |e| e.match(/^ 1/) }

queues = []
input.split("\n")[0...stop_at].each do |row|
  index = 0

  row.chars.each_slice(4) do |col|
    queues[index] = [] if queues[index].nil?

    crate = col[1].strip
    queues[index] << crate unless crate.empty?

    index += 1
  end
end

puts queues.inspect

input.split("\n")[stop_at + 2..].each do |command|
  quantity, from, to = command.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)

  # quantity.times do
    cargo = queues[from - 1].shift(quantity)
    queues[to - 1].unshift(*cargo)
  # end
end

puts queues.inspect
puts queues.map(&:first).join
