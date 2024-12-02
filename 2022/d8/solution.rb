# frozen_string_literal: true

require 'debug'

input = <<~INPUT
  30373
  25512
  65332
  33549
  35390
INPUT

# input = IO.read('input.txt')

rows = input.split("\n").map do |line|
  line.chars.map(&:to_i)
end
puts rows.inspect

visibility = Array.new(rows.size) { Array.new(rows.first.size) { true } }

# Gonna check left
rows[1..-2].each_with_index do |row, row_index|
  tallest_height = nil

  row[1..-2].each_with_index do |_, col_index|
    current_visibility = visibility[row_index + 1][col_index + 1]
    prev_height = rows[row_index + 1][col_index + 1 - 1]
    next_height = rows[row_index + 1][col_index + 1 + 2]
    current_height = rows[row_index + 1][col_index + 1]

    tallest_height = current_height if tallest_height.nil? || tallest_height < current_height

    # next if not visible already
    next unless current_visibility

    # next if it is an edge
    next if prev_height.nil? || next_height.nil?

    next if current_height >= tallest_height

    visibility[row_index + 1][col_index + 1] = false

    next
  end
end

puts visibility.inspect

trans_rows = rows.transpose
trans_rows[1..-2].each_with_index do |col, col_index|
  tallest_height = nil

  col[1..-2].each_with_index do |_, row_index|
    current_visibility = visibility[row_index + 1][col_index + 1]
    prev_height = rows[row_index + 1][col_index + 1 - 1]
    next_height = rows[row_index + 1][col_index + 1 + 1]
    current_height = rows[row_index + 1][col_index + 1]

    tallest_height = current_height if tallest_height.nil? || tallest_height < current_height

    # next if not visible already
    next unless current_visibility

    # next if it is an edge
    next if prev_height.nil? || next_height.nil?

    next if current_height >= tallest_height

    visibility[row_index + 1][col_index + 1] = false

    next
  end
end

puts visibility.inspect
