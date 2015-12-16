require 'pry'

class Node
  attr_reader :link
  attr_accessor :word, :weight

  def initialize(link = {}, word=nil, weight=0)
    @link = link
    @word = word
    @weight = weight
  end
end

if __FILE__ == $0
  node = Node.new
  node.link # => {}
end
