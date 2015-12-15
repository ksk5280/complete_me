require 'minitest'
require 'pry'
require 'trie'

class TrieTest < Minitest::Test
  def setup
    @trie = Trie.new
  end
  def test_class_exists
    assert Trie
  end

  def test_can_create_instances
    assert_instance_of Trie, @trie
  end

  def test_can_insert_word_create_first_node
    @trie.insert("pizza")
    assert_equal ({"p": })
  end

end
