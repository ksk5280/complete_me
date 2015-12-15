require 'pry'

class Trie
  attr_reader :root
  def initialize
    @root = Node.new
  end

  def insert(inserted_word, node=root)
    inserted_word.downcase.each_char.with_index do |letter, index|
      if node.link.has_key?(letter)
        # follow path to next node
      else
        # create new node with that letter
        node.link[:letter] = nil
        depth = index + 1
        if index == inserted_word.length
          word = inserted_word
        else
          word = nil
        end
        node = Node.new(depth, word, node.link)
      end
    end
  end
end
