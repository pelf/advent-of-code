MOVES = File.read('input.txt').split(',')
@progs = ('a'..'p').to_a

# part 1

MOVES.each do |move|
  case move
  when /s(\d+)/
    @progs.rotate!(-1 * $1.to_i)
  when /x(\d+)\/(\d+)/
    @progs[$1.to_i], @progs[$2.to_i] = @progs[$2.to_i], @progs[$1.to_i]
  when /p(\w)\/(\w)/
    p1 = @progs.index $1
    p2 = @progs.index $2
    @progs[p1], @progs[p2] = @progs[p2], @progs[p1]
  end
end

puts @progs.join

# part 2

# find char mapping to speed things up
mapping = []
('a'..'p').each_with_index do |c, i|
  mapping[@progs.index(c)] = i
end

@progs = ('a'..'p').to_a

1_000_000_000.times do
  new_progs = []
  mapping.each_with_index do |m, i|
    new_progs[i] = @progs[m]
  end
  @progs = new_progs
end

puts @progs.join
