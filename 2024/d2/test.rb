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
      [37, 35, 34, 33, 29]
    ]
  end

  def test_safe_report
    assert safe_report?(@input[0])
    refute safe_report?(@input[1])
    refute safe_report?(@input[2])
    refute safe_report?(@input[3])
    refute safe_report?(@input[4])
    assert safe_report?(@input[5])
    refute safe_report?(@input[6])
    refute safe_report?(@input[7])
    refute safe_report?(@input[8])
    refute safe_report?(@input[9])
  end

  def test_safe_report_with_dampening
    assert safe_report?(@input[0], dampening: true)

    refute safe_report?(@input[1], dampening: true)
    refute safe_report?(@input[2], dampening: true)

    assert safe_report?(@input[3], dampening: true)
    assert safe_report?(@input[4], dampening: true)
    assert safe_report?(@input[5], dampening: true)
    assert safe_report?(@input[6], dampening: true)

    assert safe_report?(@input[7], dampening: true), 'safe if remove 41'
    assert safe_report?(@input[8], dampening: true), 'safe if remove 37'
    assert safe_report?(@input[9], dampening: true), 'safe if remove 29'
  end

  def test_individual
    assert safe_report?('10 13 13 15 16'.split.map(&:to_i), dampening: true)
  end

  def test_count_valid_reports
    assert_equal count_valid_reports(@input), 2
    assert_equal count_valid_reports(@input, dampening: true), 8
  end
end
