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

  def test_can_insert_one_word
    @trie.insert("pizza")
    assert @trie.root.link.has_key?("p")
    assert_equal 1, @trie.count
  end

  def test_can_insert_two_words
    @trie.insert("pizza")
    @trie.insert("food")
    assert @trie.root.link.has_key?("p")
    assert @trie.root.link.has_key?("f")
    assert_equal 2, @trie.count
  end

  def test_can_insert_three_words
    @trie.insert("pizza")
    @trie.insert("food")
    @trie.insert("pizzeria")
    assert_equal ["p", "f"], @trie.root.link.keys
    assert_equal 3, @trie.count
  end

  def test_can_populate_dictionary
    dictionary = "/usr/share/dict/words"
    @trie.populate(dictionary)
    assert_equal 235886, @trie.count
  end

  def test_can_suggest_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")

    expected = ["pizza", "pizzeria", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")
  end
end
