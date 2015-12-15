require 'minitest'
require 'pry'
require 'trie'

class TrieTest < Minitest::Test
  def test_class_exists
    assert Trie
  end

  def test_can_create_instances
    trie = Trie.new
    assert_instance_of Trie, trie
  end

  
end
