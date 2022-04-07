class NodeBuilder

  attr_reader :node

  def self.build(node_id)
    new.build(node_id)
  end

  def build(node_id)
    result = get_nodes(node_id)
    build_node(result.first)
  end

  private

  def build_node(response_node)
    {
      id: response_node['id'],
      children: get_nodes(response_node['child_node_ids']).map{ |child_node| build_node(child_node) }
    }
  end

  def get_nodes(node_ids)
    NodeApi.get(node_ids)
  end
end
