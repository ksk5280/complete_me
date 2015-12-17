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
    read_file.split.each do |word|
      insert(word)
    end
  end

  def count_words(node=root)
    find_words(node).length
  end

  def suggest(substring)
    substring_node = traverse_substring(substring)
    suggestions = find_words(substring_node)
    sorted_nodes = suggestions.sort! do |a, b|
      b.weight <=> a.weight
    end
    sorted_words = sorted_nodes.map do |node|
      node.word
    end
    sorted_words
  end

  def find_words(node=root)
    word_arr = []
    word_arr.push(node) if !node.word.nil?
    node.link.each do |_, value|
      word_arr.concat(find_words(value))
    end
    word_arr
  end

  def traverse_substring(substring, node=root)
    return node if substring.empty?
    node_link = node.link[substring.slice!(0)]
    return nil if node_link.nil?
    return traverse_substring(substring, node_link)
  end

  def select(_suggested_word, selected_word)
    node = traverse_substring(selected_word)
    node.weight += 1
    node
  end

  def delete(word, node = root)
    index = 0
    while suggest(word.slice(0..index)).length > 1
      index += 1
    end
    key_to_delete = word.slice(index)
    node_to_delete_from = traverse_substring(word.slice(0..index-1))
    node_to_delete_from.link.delete(key_to_delete)
  end
end


if __FILE__ == $0
  cm = CompleteMe.new
  cm.insert("pizza")
  cm.insert("pizzeria")
  cm.insert("pizzicato")
  cm.select("piz", "pizzeria")
  cm.suggest("piz")
  cm.delete("pizzeria")
  # filepath = File.expand_path("../../word_list.txt", __FILE__)
  # word_list = File.read(filepath)
  # cm.populate(word_list)
end
