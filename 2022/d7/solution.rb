# frozen_string_literal: true
# TODO: why to_s vs to_str

require 'debug'
require_relative 'foo_file'
require_relative 'tree'
require_relative 'node'


# input = <<~INPUT
#   $ cd /
#   $ ls
#   dir a
#   14848514 b.txt
#   8504156 c.dat
#   dir d
#   $ cd a
#   $ ls
#   dir e
#   29116 f
#   2557 g
#   62596 h.lst
#   $ cd e
#   $ ls
#   584 i
#   $ cd ..
#   $ cd ..
#   $ cd d
#   $ ls
#   4060174 j
#   8033020 d.log
#   5626152 d.ext
#   7214296 k
# INPUT

input = IO.read('input.txt')

tree = Tree.new

input.split("\n").each do |line|
  case line
  when /\$ cd (.+)/
    directory = Regexp.last_match(1)

    case directory
    when '/'
      tree.root!
    when '..'
      tree.up!
    else
      tree.down!(directory)
    end

  when /dir (.+)/
    name = Regexp.last_match(1)
    file = FooFile.new(name:, type: :directory)

    tree.add_file(file)

  when /(\d+) (.+)/
    size = Regexp.last_match(1).to_i
    name = Regexp.last_match(2)
    file = FooFile.new(size:, name:, type: :file)

    tree.add_file(file)

  when /\$ ls/

  else
     raise "#{line} WTF!"
  end
end

directories = []
Tree.nav(tree.root) do |node, depth|
  directories << node if node.type == :directory
end

MAX_SIZE = 70_000_000
CURRENT_SIZE = tree.root.size
AVAILABLE_SIZE = MAX_SIZE - CURRENT_SIZE
MIN_SPACE_FOR_UPDATE = 30_000_000
MAX_DIR_SIZE = MIN_SPACE_FOR_UPDATE - AVAILABLE_SIZE


puts "---- Tree"
puts tree
puts "---- Root size"
puts tree.root.size
puts "---- Available space"
puts AVAILABLE_SIZE
puts "---- Need at least"
puts MAX_DIR_SIZE
puts "---- Files to free enough for update"
puts directories.find_all { |d| d.size >= MAX_DIR_SIZE }
puts "---- Min"
min_file = directories.find_all { |d| d.size >= MAX_DIR_SIZE }.min
puts min_file.name
puts min_file.size
