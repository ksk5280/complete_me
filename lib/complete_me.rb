require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root, :count, :weight

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(inserted_word, node=root)
    @count += 1
    inserted_word.each_char do |letter|
      if !node.link.has_key?(letter)
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

  def number_of_words_below_node(node=root)
    traverse_branches_to_find_words(node).length
  end

  def suggest(substring)
    traverse_branches_to_find_words(traverse_substring(substring))
  end

  def traverse_branches_to_find_words(node=root)
    word_arr = []
    word_arr.push(node.word) if !node.word.nil?
    node.link.each do |_, value|
      word_arr.concat(traverse_branches_to_find_words(value))
    end
    word_arr
  end

  def traverse_substring(substring, node=root)
    return node if substring.empty?
    node_link = node.link[substring.slice!(0)]
    return nil if node_link.nil?
    return traverse_substring(substring, node_link)
  end

  def select(selected_word)
    node = traverse_substring(selected_word)
    node.weight += 1
    node
  end

  def delete

  end
end


if __FILE__ == $0
  cm = CompleteMe.new
  cm.insert("pizza")
  cm.insert("pizzeria")
  cm.insert("pizzicato")
  # cm.root.link.keys # => ["p", "f"]
  # cm.count # => 3
  # dictionary = "/usr/share/dict/words"
  # cm.populate(dictionary)
  # cm.count # => 235886
  # cm.suggest("piz") # => ["pizza", "pizzeria", "pizzicato"]
  cm.select("pizza")
end
