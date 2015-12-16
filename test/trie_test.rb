require 'minitest'
require 'pry'
require 'trie'
require_relative 'test_helper'

class TrieTest < Minitest::Test
  attr_reader :root

  def setup
    @trie = Trie.new
  end
  def test_class_exists
    assert Trie
  end

  def test_can_create_instances
    assert_instance_of Trie, @trie
  end

  def test_trie_initializes_with_root_node
    assert_instance_of Node, @trie.root
  end

  def test_inserted_letter_creates_link_key_at_root
    @trie.insert("a")
    assert @trie.root.link.has_key?("a")
  end

  def test_can_insert_two_words
    @trie.insert("pizza")
    @trie.insert("food")
    assert @trie.root.link.has_key?("p")
    assert @trie.root.link.has_key?("f")
  end

  def test_can_insert_three_words
    @trie.insert("pizza")
    @trie.insert("food")
    @trie.insert("pizzeria")
    assert_equal ["p", "f"], @trie.root.link.keys
  end
end
