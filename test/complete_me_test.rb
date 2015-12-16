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


end
