class NodeApi

  URL = 'https://nodes-on-nodes-challenge.herokuapp.com/nodes/'.freeze

  attr_reader :result

  def self.get(node_ids)
    new.get(node_ids)
  end

  def get(node_ids)
    @result = client_get(node_ids)
  end

  private

  def client_get(node_ids)
    result = HTTParty.get("#{URL}#{normalized_params(node_ids)}")
    result.success? ? JSON.parse(result.body) : []
  end

  def normalized_params(node_ids)
    return node_ids unless node_ids.is_a? Array

    node_ids.join(',')
  end
end
