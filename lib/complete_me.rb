require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root, :weight

  def initialize
    @root = Node.new
  end

  def insert(inserted_word, node=root)
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

  def count(node=root)
    find_words(node).length
  end

  def suggest(substring)
    suggestions = find_words(traverse_substring(substring))
    sorted_nodes = suggestions.sort! { |a, b| b.weight <=> a.weight }
    sorted_words = sorted_nodes.map {|node| node.word }
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

  def delete(word_to_delete, node = root)
    index = 0
    until suggest(word_to_delete.slice(0..index)).length == 1 || index == word_to_delete.length
      index += 1
    end
    substring_node = traverse_substring(word_to_delete.slice(0..index-1))
    key_to_delete = word_to_delete.slice(index)
    if key_to_delete.nil?
      substring_node.word = nil
    else
      substring_node.link.delete(key_to_delete)
    end
  end
end

if __FILE__ == $0
  trie = CompleteMe.new
  trie.insert("pi")
  trie.insert("pizza")
  trie.insert("pizzeria")
  trie.insert("pizzicato")
  trie.delete("pi")
end
