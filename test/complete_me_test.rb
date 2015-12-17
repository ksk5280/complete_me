require 'minitest'
require 'complete_me'
require 'pry'
require_relative 'test_helper'

class CompleteMeTest < Minitest::Test
  attr_reader :root

  def setup
    @trie = CompleteMe.new
  end

  def test_class_exists
    assert CompleteMe
  end

  def test_can_create_instances
    assert_instance_of CompleteMe, @trie
  end

  def test_count_starts_at_zero
    assert_equal 0, @trie.count
  end

  def test_trie_initializes_with_root_node
    assert_instance_of Node, @trie.root
  end

  def test_can_insert_one_word
    @trie.insert("pizza")
    assert @trie.root.link.has_key?("p")
    assert @trie.root.link["p"].link.has_key?("i")
    assert_equal 1, @trie.count
  end

  def test_can_insert_two_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    assert_equal ["p", "h"], @trie.root.link.keys
    assert_equal 2, @trie.count
  end

  def test_can_insert_three_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    @trie.insert("salad")

    assert_equal ["p", "h", "s"], @trie.root.link.keys
    assert_equal 3, @trie.count
  end

  def test_can_traverse_substring
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.suggest("piz")

    actual = @trie.traverse_substring("piz").link.keys
    assert_equal ["z"], actual
  end

  def test_can_populate_words
    @trie.populate("pizza\nhouse\ncar\ntree")
    assert_equal 4, @trie.count
  end

  def test_can_count_words_in_the_tree
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.insert("word")
    @trie.insert("house")
    @trie.insert("car")
    @trie.insert("cat")
    @trie.insert("dog")
    @trie.insert("piano")
    assert_equal 9, @trie.count_words
  end

  def test_can_suggest_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.insert("plate")

    expected = ["pizza", "pizzeria", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_add_weight_to_selected_words
    @trie.insert("pizza")
    assert_equal 1, @trie.select("piz", "pizza").weight
    assert_equal 2, @trie.select("piz", "pizza").weight
    assert_equal 3, @trie.select("piz", "pizza").weight
  end

  def test_can_suggest_weighted_words_first
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.select("piz", "pizzeria")
    expected = ["pizzeria", "pizza", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_delete_words
    @trie.insert("pi")
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    assert_equal 4, @trie.count_words
    @trie.delete("pizza")
    assert_equal 3, @trie.count_words
    @trie.delete("pizzeria")
    assert_equal 2, @trie.count_words
  end
end
