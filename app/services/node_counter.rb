class NodeCounter
  attr_reader :node_id, :node, :results

  DEFAULT_NODE_ID = '089ef556-dfff-4ff2-9733-654645be56fe'.freeze

  def count
    @node = NodeBuilder.build(node_id)
    analyze_node(node)
    self
  end

  def unique_nodes
    results.select{ |node_id, counter| counter == 1 }.keys
  end

  def most_shared_nodes
    max_ocurrences = results.values.max
    results.select{ |node_id, counter| counter == max_ocurrences }.keys
  end

  private

  def initialize(node_id = nil)
    @node_id = node_id || DEFAULT_NODE_ID
    @results = {}
  end

  def analyze_node(node)
    @results[node[:id]] ||= 0
    @results[node[:id]] += 1
    node[:children].each{ |child_node| analyze_node(child_node) }
  end
end
