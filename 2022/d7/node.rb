class Node
  attr_reader :file, :children, :parent

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

  def <=>(other)
    size <=> other.size
  end
end
