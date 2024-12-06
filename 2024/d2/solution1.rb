# frozen_string_literal: true

def safe_report?(levels, dampening: false)
  return valid_levels?(levels) unless dampening

  return true if valid_levels?(levels)

  levels.size.times do |i|
    subset = levels[...i] + levels[i + 1...]
    return true if valid_levels?(subset)
  end

  false
end

def valid_levels?(levels)
  levels.each_cons(2)
        .map { |a, b| inc?(a, b) }
        .uniq.count == 1
end

def inc?(n1, n2)
  return nil unless (n1 - n2).abs.between?(1, 3)

  n1 < n2
end

def count_valid_reports(input, dampening: false)
  input.count do |line|
    safe_report?(line, dampening:)
  end
end
