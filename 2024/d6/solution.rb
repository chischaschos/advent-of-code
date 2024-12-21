# frozen_string_literal: true

Location = Struct.new(:x, :y, :direction)

class Guard
  LOOK_UP = '^'
  LOOK_DOWN = 'v'
  LOOK_RIGHT = '>'
  LOOK_LEFT = '<'
  DIRECTIONS = [LOOK_UP, LOOK_RIGHT, LOOK_DOWN, LOOK_LEFT].freeze

  attr_accessor :lab_map, :current_location, :visited_locations, :current_direction

  def initialize(lab_map:, x:, y:)
    @directions = DIRECTIONS.cycle
    @current_location = Location.new(x:, y:, direction: @directions.next)
    @lab_map = lab_map
    @visited_locations = Hash.new(0)
    @visited_locations[current_location.clone] += 1
  end

  def move!
    return if stuck? || obstacle_ahead?

    lab_map[y][x] = 'X'

    case current_location.direction
    when LOOK_UP then current_location.y -= 1
    when LOOK_DOWN then current_location.y += 1
    when LOOK_LEFT then current_location.x -= 1
    when LOOK_RIGHT then current_location.x += 1
    end

    return if stuck?

    lab_map[y][x] = current_location.direction
    @visited_locations[current_location.clone] += 1
  end

  def obstacle_ahead?
    case current_location.direction
    when LOOK_UP then lab_map.fetch(y - 1, [])[x] == '#'
    when LOOK_RIGHT then lab_map.fetch(y, [])[x + 1] == '#'
    when LOOK_DOWN then lab_map.fetch(y + 1, [])[x] == '#'
    when LOOK_LEFT then lab_map.fetch(y, [])[x - 1] == '#'
    end
  end

  def turn!
    new_direction = @directions.next
    lab_map[y][x] = new_direction
    self.current_location = Location.new(x:, y:, direction: new_direction)
    @visited_locations[current_location.clone] += 1
  end

  def out? = x.negative? || x >= lab_map[0].size || y.negative? || y >= lab_map.size

  def x = current_location.x

  def y = current_location.y

  def loop_found? = visited_locations[current_location] > 1

  def stuck? = out? || surrounded? || loop_found?

  def surrounded?
    [[y - 1, x],
     [y, x + 1],
     [y + 1, x],
     [y, x - 1]].all? { |p| lab_map[p[0]][p[1]] == '#' }
  end

  def add_wall!(loc) = lab_map[loc.y][loc.x] = '#'

  def printable_map = lab_map.map(&:join).join("\n")
end

def follow(guard:)
  # debugger if guard.loop_found?

  return guard if guard.stuck?

  if guard.obstacle_ahead?
    guard.turn!
  else
    guard.move!
  end

  follow(guard:)
end
