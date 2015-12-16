require 'minitest'
require 'complete_me'
require 'pry'
require_relative 'test_helper'

class CompleteMeTest < Minitest::Test
  attr_reader :complete
  def setup
    @complete = CompleteMe.new
  end

  def test_class_exists
    assert CompleteMe
  end

  def test_can_create_instances
    assert_instance_of CompleteMe, complete
  end

  def test_count_starts_at_zero
    assert_equal 0, complete.count
  end

  attr_reader :root

  def setup
    @trie = Trie.new
    @dictionary = "/usr/share/dict/words"
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

  def test_can_populate_dictionary
    @trie.populate(@dictionary)
    assert_equal 235886, @trie.count
  end

  def test_can_count_words_in_the_tree
    @trie.populate(@dictionary)
    assert_equal 235886, @trie.number_of_words_below_node
  end

  def test_can_suggest_inserted_words
    @trie.insert("pizza")
    @trie.insert("pizzeria")
    @trie.insert("pizzicato")

    expected = ["pizza", "pizzeria", "pizzicato"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_suggest_dictionary_words
    @trie.populate(@dictionary)

    expected = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
    assert_equal expected, @trie.suggest("piz")
  end

  def test_can_suggest_dictionary_words
    @trie.populate(@dictionary)

    expected = ["zooxanthella", "zooxanthellae", "zooxanthin"]
    assert_equal expected, @trie.suggest("zoox")
  end

  def test_can_add_weight_to_selected_words
    @trie.insert("pizza")
    assert_equal 1, @trie.select("pizza").weight
    assert_equal 2, @trie.select("pizza").weight
    assert_equal 3, @trie.select("pizza").weight
  end
end
