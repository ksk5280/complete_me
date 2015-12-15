require 'pry'

class Node
  attr_reader :word, :depth, :link
  def initialize(depth=0, word=nil, link = {})
    @depth = depth
    @word = word
    @link = link
  end
end

if __FILE__ == $0
  node = Node.new
  node.link # => {}
end
