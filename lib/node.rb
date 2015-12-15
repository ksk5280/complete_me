require 'pry'

class Node
  attr_reader :word, :depth, :link
  def initialize(link)
    @word = nil
    @depth = 0
    @link = link
  end
end

if __FILE__ == $0
  node = Node.new({"p":nil})
  node.link # => {:p=>nil}
end
