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

  # def read_file(file_name)
  #   file_handler = File.open("word_list.txt", "r")
  #   # file_handler.each_line do |line|
  #   #   # insert into Trie?
  #   # end
  #   file_handler.close
  # end

  def populate(read_file)
    read_file.split.each do |word|
      insert(word)
    end
  end

  def number_of_words_below_node(node=root)
    traverse_branches_to_find_words(node).length
  end

  def suggest(substring)
    suggestions = traverse_branches_to_find_words(traverse_substring(substring))
    sorted = suggestions.sort! do |a, b|
      b.weight <=> a.weight
    end
    sorted_words = sorted.map do |node|
      node.word
    end
    sorted_words
  end

  # def sort_node_array_by_weight(suggestions)
  #   sorted = suggestions.map do |node|
  #     node.weight
  #   end
  #   sorted.sort # => [0, 0, 1]
  # end

  def traverse_branches_to_find_words(node=root)
    word_arr = []
    word_arr.push(node) if !node.word.nil?
    # binding.pry
    node.link.each do |_, value|
      word_arr.concat(traverse_branches_to_find_words(value))
    end
    word_arr
  end

  # def traverse_branches_to_find_words(node=root)
  #   word_arr = []
  #   word_arr.push({node.word => node.weight}) if !node.word.nil?
  #   binding.pry
  #   node.link.each do |_, value|
  #     word_arr.concat(traverse_branches_to_find_words(value))
  #   end
  #   word_arr
  # end

  def traverse_substring(substring, node=root)
    return node if substring.empty?
    node_link = node.link[substring.slice!(0)]
    return nil if node_link.nil?
    return traverse_substring(substring, node_link)
  end

  def select(suggested_word, selected_word)
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
  # cm.select("pizza")

  cm.select("piz", "pizzeria")
  cm.suggest("piz") # => ["pizzeria", "pizza", "pizzicato"]

  # filepath = File.expand_path("../../word_list.txt", __FILE__)
  # word_list = File.read(filepath)
  # cm.populate(word_list)
end
