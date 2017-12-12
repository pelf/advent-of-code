require 'set'
require 'pry'

input = File.read('input.txt')
links = input.split("\n")

class Node
  attr_accessor :name, :links, :processed
  def initialize(name)
    @name = name
    @links = Set.new
  end
end

# build graph
nodes = {}

links.each do |edges|
  edges =~ /(\d+) <-> (.+)/
  origin = $1.to_i
  # initialise origin
  origin = (nodes[origin] ||= Node.new(origin))
  dests = $2.split(',').map(&:to_i)
  dests.each do |dest|
    # initialise dest
    dest = (nodes[dest] ||= Node.new(dest))
    # link them
    dest.links << origin
    origin.links << dest
  end
end

# part 1

# start from node 0
queue = [nodes[0]]
processed = {}

loop do
  break unless queue.any?
  # get node to process
  cur = queue.shift
  # mark it as processed
  processed[cur.name] = true
  # for each linked node
  cur.links.each do |node|
    # skip if we've been there before
    next if processed[node.name]
    # put in the processing queue
    queue << node
  end
end

puts processed.size

# part 2

group = 0

loop do
  # find node we haven't seen before
  node = nodes.find { |_,node| !node.processed }
  break unless node # are we done?
  queue = [node[1]] # hash.find returns [k,v]
  group += 1

  loop do
    break unless queue.any?
    # get node to process
    cur = queue.shift
    # mark it as processed
    cur.processed = true
    # for each linked node
    cur.links.each do |node|
      # skip if we've been there before
      next if node.processed
      # put in the processing queue
      queue << node
    end
  end
end

puts group
