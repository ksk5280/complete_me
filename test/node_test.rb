require 'minitest'
require 'pry'
require 'node'
require_relative 'test_helper'

class NodeTest < Minitest::Test
  def test_class_exists
    assert Node
  end

  def test_can_create_instances
    node = Node.new
    assert_instance_of Node, node
  end

  def test_node_initializes_with_values
    node = Node.new
    assert_equal 0, node.weight
    assert_equal nil, node.word
    assert_equal ({}), node.link
  end
end
