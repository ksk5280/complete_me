require 'pry'
require_relative 'node'

class Trie
  attr_reader :root, :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(inserted_word, node=root)
    @count += 1
    inserted_word.each_char do |letter|
      if node.link.has_key?(letter)
      else
        node.link[letter] = Node.new
      end
      node = node.link[letter]
    end
    node.word = inserted_word
  end

  def populate(read_file)
    File.read(read_file).split.each do |word|
      insert(word)
    end
  end

  def suggest(substring)

  end
end

if __FILE__ == $0
  trie = Trie.new
  # trie.insert("pizza")
  # trie.insert("pizzeria")
  # trie.insert("food")
  # trie.root.link.keys # => ["p", "f"]
  # trie.count # => 3
  dictionary = "/usr/share/dict/words"
  trie.populate(dictionary)
  trie.count # => 235886
  
end
