Node = Data.define(:v, :depth, :edges)

Edge = Data.define(:node, :v)

class Graph
  attr_reader :root

  def initialize(root:)
    @root = root
  end


  def paths
    to_visit = [[root, [root.v]]]

    loop do
      break if to_visit.empty?

      current_node, path = to_visit.shift

      yield path if current_node.edges.empty?

      edge_tuples = current_node.edges.map{ |e| [ e.node, path + [e.v] + [e.node.v] ] }

      to_visit.unshift(*edge_tuples)
    end
  end

  def to_s
    to_visit = [root]

    loop do
      break if to_visit.empty?

      current_node = to_visit.shift
      puts " " * current_node.depth + current_node.v.to_s

      to_visit.unshift(*current_node.edges.map(&:node))
    end
  end
end
