require 'pry'
require_relative 'node'
require_relative 'trie'

class CompleteMe
  attr_accessor :count

  def initialize
    @count = 0
  end

  def insert(word)
    word_list = []
    word_list << word
    @count += 1
  end
end
