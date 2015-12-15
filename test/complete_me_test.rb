require 'minitest'
require 'complete_me'
require 'pry'

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

  def test_can_insert_word_and_count_words
    complete.insert("word")
    assert_equal 1, complete.count
  end
end
