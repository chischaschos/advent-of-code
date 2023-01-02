class FooFile
  attr_reader :name, :type
  attr_accessor :size

  def initialize(name:, type:, size: 0)
    @size = size
    @name = name
    @type = type
  end

  def to_s
    "#{type}, size=#{size}"
  end
end
