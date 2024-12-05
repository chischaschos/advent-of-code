# frozen_string_literal: true

# given a level
# all numbers increse or decrease by valid_increase
def safe_report?(levels, dampening: false)
  return true if levels.size.between?(0, 1)

  return !inc?(*levels).nil? if levels.size == 2

  a, b, c, = levels
  prev = nil
  index = nil
  direction = nil

  if inc?(a, b).nil?
    return false unless dampening

    result = inc?(a, c)

    if result.nil?
      result = inc?(b, c)

      return false if result.nil?

      prev = b
      index = 2
      direction = result

    else
      prev = a
      index = 2
      direction = result
    end

  else
    prev = a
    index = 1
    direction = inc?(a, b)
  end

  error_threshold = 1

  loop do
    break if index == levels.size

    curr = levels[index]

    result = inc?(prev, curr)

    if result.nil? || result != direction
      return false unless dampening

      return false if error_threshold.zero?

      error_threshold -= 1
      curr = prev
    end

    prev = curr
    index += 1
  end

  true
end

# nil error
# true n1 increases to n2
# false n1 decreases to n2
def inc?(n1, n2)
  return nil unless (n1 - n2).abs.between?(1, 3)

  n1 < n2
end

def count_valid_reports(input, dampening: false)
  input.count do |line|
    safe_report?(line, dampening:)
  end
end
