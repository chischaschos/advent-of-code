require_relative 'part1'
require 'minitest/autorun'
require 'debug'

class Part1Test < Minitest::Test
  def setup
    @input = [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9]
    ]
  end

  def test_safe_report
    assert safe_report?(@input[0])
    refute safe_report?(@input[1])
    refute safe_report?(@input[2])
    refute safe_report?(@input[3])
    refute safe_report?(@input[4])
    assert safe_report?(@input[5])
  end
end
