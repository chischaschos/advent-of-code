# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'debug'
require_relative 'solution1'

class Part1Test < Minitest::Test
  def setup
    @input = [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9],
      [8, 6, 4, 4, 1],
      [41, 37, 35, 34, 33],
      [37, 35, 34, 33, 37],
      [37, 35, 34, 33, 29],
      [10, 9, 10, 13, 15, 16],
      [10, 9, 10, 8, 7, 6, 5]
    ]
  end

  def test_safe_report
    assert safe_report?(@input[0])
    assert safe_report?(@input[0], dampening: true)

    refute safe_report?(@input[1])
    refute safe_report?(@input[1], dampening: true)

    refute safe_report?(@input[2])
    refute safe_report?(@input[2], dampening: true)

    refute safe_report?(@input[3])
    assert safe_report?(@input[3], dampening: true)

    refute safe_report?(@input[4])
    assert safe_report?(@input[4], dampening: true)

    assert safe_report?(@input[5])
    assert safe_report?(@input[5], dampening: true)

    refute safe_report?(@input[6])
    assert safe_report?(@input[6], dampening: true)

    refute safe_report?(@input[7])
    assert safe_report?(@input[7], dampening: true)

    refute safe_report?(@input[8])
    assert safe_report?(@input[8], dampening: true)

    refute safe_report?(@input[9])
    assert safe_report?(@input[9], dampening: true)

    refute safe_report?(@input[10])
    assert safe_report?(@input[10], dampening: true)

    refute safe_report?(@input[11])
    assert safe_report?(@input[11], dampening: true)
  end
end
