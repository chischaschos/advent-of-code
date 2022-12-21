# frozen_string_literal: true
# TODO: why to_s vs to_str

require 'debug'

class FooFile
  attr_reader :name, :type
  attr_accessor :size

  def initialize(size: 0, name:, type:)
    @size = size
    @name = name
    @type = type
  end

  def to_s
    "#{type}, size=#{size}"
  end
end

class Node
  attr_reader :file
  attr_reader :children
  attr_reader :parent

  def initialize(parent:, file:)
    @file = file
    @children = []
    @parent = parent
  end

  def type
    file.type
  end

  def name
    file.name
  end

  def size
    file.size
  end

  def size=(s)
    file.size = s
  end

  def to_s
    to_str
  end

  def to_str
    "- #{name} (#{file})"
  end
end

class Tree
  attr_reader :root
  attr_reader :current

  def initialize
    file = FooFile.new(name: '/', type: :directory)
    @root = Node.new(parent: nil, file:)
    @current = @root
  end

  def root!
    @current = root
  end

  def add_file(file)
    add_size(current, file.size) if file.type == :file
    current.children << Node.new(parent: current, file:)
  end

  def down!(directory_name)
    directory = current.children.find do |child|
      child.type == :directory && child.name == directory_name
    end

    # binding.break
    raise "#{directory_name} does not exists" unless directory

    @current = directory
  end

  def up!
    @current = current.parent
  end

  private

  def add_size(node, size)
    return if node.nil?

    node.size += size
    add_size(node.parent, size)
  end
end

tree = Tree.new

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

def nav(node, depth: 0, &block)
  block.call(node, depth)

  node.children.each do |c|
    nav(c, depth: depth + 1, &block)
  end
end

nav(tree.root) do |node, depth|
  puts ' ' * depth + node
end

puts "\ndirs with at most 100000"

directories = []
nav(tree.root) do |node, depth|
  directories << node if node.type == :directory
end

puts directories.find_all { |d| d.size <= 100000 }
puts directories.find_all { |d| d.size <= 100000 }
  .sum { |d| d.size }
