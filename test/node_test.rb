require 'minitest'
require 'pry'
require 'node'

class NodeTest < Minitest::Test
  def test_class_exists
    assert Node
  end

  def test_can_create_instances
    node = Node.new({"p":nil})
    assert_instance_of Node, node
  end

  def test_node_initializes_with_values
    node = Node.new({"p":nil})
    assert_equal 0, node.depth
    assert_equal nil, node.word
    assert_equal ({"p":nil}), node.link
  end
end
