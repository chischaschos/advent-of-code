# given a level
# all numbers increse or decrease by valid_increase
def safe_report?(levels)
  increasing = nil

  prev = levels[0]

  levels[1..].each do |level|
    return false unless valid_delta?(prev, level)

    if increasing.nil?
      increasing = level > prev

    elsif increasing && level < prev || !increasing && prev < level
      return false

    end

    prev = level
  end

  true
end

def valid_delta?(n1, n2)
  delta = (n1.abs - n2.abs).abs
  delta >= 1 && delta <= 3
end

input = IO.read('input.txt')

puts(input.split("\n").count do |line|
  safe_report?(line.split.map(&:to_i))
end)
