require 'pry'

class Node
  attr_reader :link, :weight
  attr_accessor :word

  def initialize(link = {}, word=false, weight=0)
    @link = link
    @word = word
    @weight = weight
  end
end

if __FILE__ == $0
  node = Node.new
  node.link # => {}
end
