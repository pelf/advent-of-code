input = "63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24"
lengths = input.split(',').map{|l| l.strip.to_i }

# part 1

list = (0..255).to_a
pos = skip = 0

lengths.each do |length|
  # reverse sub-list
  (length/2).times do |pos_inc|
    # swap first with last, etc
    s1 = (pos + pos_inc) % list.length
    s2 = (pos + length - 1 - pos_inc) % list.length
    list[s1], list[s2] = list[s2], list[s1]
  end
  pos = (pos + length + skip) % list.length
  skip += 1
end

puts list[0] * list[1]

# part 2

lengths = input.each_char.map(&:ord) + [17, 31, 73, 47, 23]

list = (0..255).to_a
pos = skip = 0

# same thing but 64 times
64.times do
  lengths.each do |length|
    # reverse sub-list
    (length/2).times do |pos_inc|
      # swap elements
      s1 = (pos + pos_inc) % list.length
      s2 = (pos + length - 1 - pos_inc) % list.length
      list[s1], list[s2] = list[s2], list[s1]
    end
    pos = (pos + length + skip) % list.length
    skip += 1
  end
end

# xor in groups of 16 and convert to hex (using 2 digits)
puts list.each_slice(16).map { |g| g.reduce(:^).to_s(16).rjust(2, '0') }.join
