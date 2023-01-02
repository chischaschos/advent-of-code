class Tree
  attr_reader :root
  attr_reader :current

  def self.nav(node, depth: 0, &block)
    block.call(node, depth)

    node.children.each do |c|
      nav(c, depth: depth + 1, &block)
    end
  end

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

  def to_s
    tree = ""
    self.class.nav(root) do |node, depth|
      tree += ' ' * depth + node + "\n"
    end
    tree
  end

  private

  def add_size(node, size)
    return if node.nil?

    node.size += size
    add_size(node.parent, size)
  end
end

