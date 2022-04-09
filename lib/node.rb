# frozen_string_literal: true

class Node
  attr_reader :position, :parent
  @@history = []
  TRANSFORMATIONS = [[1, 2], [1, -2], [2, 1], [2, -1],
                     [-1, 2], [-1, -2], [-2, 1], [-2, -1]].freeze

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @@history.push(position)
  end

  def get_children
    TRANSFORMATIONS.map { |t| [@position[0] + t[0], @position[1] + t[1]]}
                   .keep_if { |e| Node.valid?(e) }
                   .reject { |e| @@history.include?(e) }
                   .map { |e| Node.new(e, self)}
  end

  def self.valid?(position)
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end
end

def display_parent(node)
  display_parent(node.parent) unless node.parent.nil?
  p node.position
end

def knight_moves(start_position, end_position)
  queue = []
  current_node = Node.new(start_position)
  until current_node.position == end_position
    current_node.get_children.each { |child| queue.push(child) }
    current_node = queue.shift
  end
  display_parent(current_node)
end

knight_moves([1, 1], [8, 8])