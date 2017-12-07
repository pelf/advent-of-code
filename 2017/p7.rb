require 'set'

input = File.read('./inputs/7.txt')
@links = input.split("\n")

class Disk
  attr_accessor :name, :weight, :parent, :children

  def initialize(name)
    @name = name
    @children = Set.new
  end

  def report_weight
    weight + (children.map(&:weight).reduce(:+) || 0)
  end

end

@disks = {}

@links.each do |link|
  name, weight = /(\w+)\s+\((\d+)\)/.match(link).captures
  # find or create
  parent = (@disks[name] ||= Disk.new(name))
  # if the disc was created as a child, we need to set its weight
  parent.weight = weight.to_i

  # if it has children
  if /->\s+(.+)/ =~ link
    $1.split(',').map(&:strip).each do |child_name|
      child = (@disks[child_name] ||= Disk.new(child_name))
      # link them both ways
      parent.children << child
      child.parent = parent
    end
  end
end

# part 1: find "bottom program" (root)
_name, disk = @disks.first
loop do
  break unless disk.parent
  disk = disk.parent
end

puts "root: #{disk.name}"

# part 2
root = disk

def describe(disk, level = 0)
  return disk.weight unless disk.children.any?
  cws = disk.children.map do |child|
    describe(child, level + 1)
  end
  puts "UNBALANCED: #{disk.name} - #{cws.inspect}" unless cws.uniq.size == 1
  cw = cws.reduce(:+)
  puts "L#{level} #{disk.name}: cw=#{cw}, w=#{disk.weight}, #{cw+disk.weight}"
  return disk.weight + (cw||0)
end

describe(root)

# running this will highlight the problematic disks:
#
# L2 kiatxq: cw=864, w=1232, 2096
# UNBALANCED: vwkkml - [2090, 2090, 2090, 2090, 2096]
#
# kiatxq needs to be 6 units lighter, so 1226
