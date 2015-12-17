require 'minitest'
require 'complete_me'
require 'pry'
require 'pry-byebug'
require 'pry-rescue'
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
  end

  def test_can_count_one_word
    @trie.insert("pizza")
    assert_equal 1, @trie.count
  end

  def test_can_insert_two_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    assert_equal ["p", "h"], @trie.root.link.keys
  end

  def test_can_count_two_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    assert_equal 2, @trie.count
  end

  def test_can_insert_two_similar_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    assert_equal ["p"], @trie.root.link.keys
  end

  def test_can_count_two_similar_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    assert_equal 2, @trie.count
  end

  def test_can_insert_three_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    @trie.insert("salad")
    assert_equal ["p", "h", "s"], @trie.root.link.keys
  end

  def test_can_count_three_words
    @trie.insert("pizza")
    @trie.insert("hamburger")
    @trie.insert("salad")
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

  def test_can_find_words_in_trie
    @trie.insert("pizza")
    @trie.insert("plate")
    @trie.insert("cat")

    assert_equal "pizza", @trie.find_words[0].word
    assert_equal "plate", @trie.find_words[1].word
    assert_equal "cat", @trie.find_words[2].word
  end

  def test_can_populate_words_from_string
    @trie.populate("pizza\nhouse\ncar\ntree")
    assert_equal 4, @trie.count
  end

  def test_can_count_words_in_the_trie
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.insert("word")
    @trie.insert("house")
    @trie.insert("car")
    @trie.insert("cat")
    @trie.insert("dog")
    @trie.insert("piano")
    assert_equal 9, @trie.count
  end

  def test_can_suggest_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.insert("plate")

    expected = ["pizza", "pizzeria", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_suggest_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    @trie.insert("plate")

    expected = ["plate"]
    assert_equal expected, @trie.suggest("pl")
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
    expected = ["pizza", "pizzeria", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")

    @trie.select("piz", "pizzeria")
    expected = ["pizzeria", "pizza", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")

    @trie.select("piz", "pizzicato")
    @trie.select("piz", "pizzicato")
    expected = ["pizzicato", "pizzeria", "pizza"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_delete_intermediate_words
    @trie.insert("pi")
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    assert_equal 4, @trie.count
    @trie.delete("pi")
    assert_equal 3, @trie.count
  end

  def test_can_delete_leaf_words
    @trie.insert("pi")
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")
    assert_equal 4, @trie.count
    @trie.delete("pizza")
    assert_equal 3, @trie.count
    @trie.delete("pizzeria")
    assert_equal 2, @trie.count
  end
end
