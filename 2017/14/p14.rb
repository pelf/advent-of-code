# knot hash copied from p10
def knot_hash(input)
  lengths = input.each_char.map(&:ord)  + [17, 31, 73, 47, 23]

  list = (0..255).to_a
  pos = skip = 0

  64.times do
    lengths.each do |length|
      (length/2).times do |pos_inc|
        s1 = (pos + pos_inc) % list.length
        s2 = (pos + length - 1 - pos_inc) % list.length
        list[s1], list[s2] = list[s2], list[s1]
      end
      pos = (pos + length + skip) % list.length
      skip += 1
    end
  end
  list.each_slice(16).map { |g| g.reduce(:^).to_s(16).rjust(2, '0') }.join
end

input = "xlqgujun"

rows = 0.upto(127).map do |row|
  knot_hash("#{input}-#{row}").each_char.map { |char| char.hex.to_s(2).rjust(4, '0') }.join
end

# part 1
puts rows.map { |r| r.count('1') }.reduce(:+)

# part 2
@rows = rows.map { |r| r.each_char.to_a.map { |c| c == '1' ? '#' : '0' } }

def group(nr, i, j)
  return if @rows[i][j] != '#'
  @rows[i][j] = nr
  group(nr, i-1, j) if i > 0
  group(nr, i+1, j) if i < 127
  group(nr, i, j-1) if j > 0
  group(nr, i, j+1) if j < 127
end

nr = 0

0.upto(127) do |i|
  0.upto(127) do |j|
    next if @rows[i][j] != '#'
    nr += 1
    group(nr, i, j)
  end
end

puts nr











