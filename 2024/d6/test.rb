# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'debug'
require_relative 'solution'

class GuardTest < Minitest::Test
  def test_surrounded
    input = <<~TEST_INPUT
      ..........
      ..........
      ..........
      ..........
      ..........
      ....#.....
      ...#^#....
      ....#.....
      ..........
      ..........
    TEST_INPUT

    start = input.delete("\n").index(Guard::LOOK_UP)
    lab_map = input.split("\n").map(&:chars)
    x = start % lab_map.size
    y = start / lab_map[0].size

    guard = Guard.new(lab_map: lab_map.map(&:clone), x:, y:)

    refute guard.loop_found?
    assert guard.surrounded?
    assert guard.stuck?
  end

  def test_loop1
    input = <<~TEST_INPUT
      ..........
      ..........
      ..........
      ..........
      ....#.....
      .....#....
      ...#^.....
      ....#.....
      ..........
      ..........
    TEST_INPUT

    start = input.delete("\n").index(Guard::LOOK_UP)
    lab_map = input.split("\n").map(&:chars)
    x = start % lab_map.size
    y = start / lab_map[0].size

    guard = Guard.new(lab_map: lab_map.map(&:clone), x:, y:)

    guard.move!
    guard.move!
    guard.move!
    assert_equal guard.visited_locations,
                 {
                   Location.new(x: 4, y: 6, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '^') => 1
                 }, guard.printable_map
    refute guard.loop_found?, guard.printable_map

    guard.turn!
    assert_equal guard.visited_locations,
                 {
                   Location.new(x: 4, y: 6, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '>') => 1
                 }, guard.printable_map
    assert guard.obstacle_ahead?, guard.printable_map
    refute guard.loop_found?, guard.printable_map
    refute guard.surrounded?
    refute guard.stuck?

    guard.turn!
    guard.move!
    assert_equal guard.visited_locations,
                 {
                   Location.new(x: 4, y: 6, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '>') => 1,
                   Location.new(x: 4, y: 5, direction: 'v') => 1,
                   Location.new(x: 4, y: 6, direction: 'v') => 1
                 }, guard.printable_map
    assert guard.obstacle_ahead?, guard.printable_map
    refute guard.loop_found?, guard.printable_map
    refute guard.surrounded?
    refute guard.stuck?

    guard.turn!
    assert_equal guard.visited_locations,
                 {
                   Location.new(x: 4, y: 6, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '>') => 1,
                   Location.new(x: 4, y: 5, direction: 'v') => 1,
                   Location.new(x: 4, y: 6, direction: 'v') => 1,
                   Location.new(x: 4, y: 6, direction: '<') => 1
                 }, guard.printable_map
    assert guard.obstacle_ahead?, guard.printable_map
    refute guard.loop_found?, guard.printable_map
    refute guard.surrounded?
    refute guard.stuck?

    guard.turn!
    assert_equal guard.visited_locations,
                 {
                   Location.new(x: 4, y: 6, direction: '^') => 2,
                   Location.new(x: 4, y: 5, direction: '^') => 1,
                   Location.new(x: 4, y: 5, direction: '>') => 1,
                   Location.new(x: 4, y: 5, direction: 'v') => 1,
                   Location.new(x: 4, y: 6, direction: 'v') => 1,
                   Location.new(x: 4, y: 6, direction: '<') => 1
                 }, guard.printable_map
    refute guard.obstacle_ahead?, guard.printable_map
    assert guard.loop_found?, guard.printable_map
    refute guard.surrounded?
    assert guard.stuck?
  end
end
