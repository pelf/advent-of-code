input = File.read('input.txt')
jumps = input.split("\n").map { |j| j.strip.to_i }

# part 1

pos = 0
count = 0

while pos >= 0 && pos < jumps.size do
  count += 1
  jump = jumps[pos]
  jumps[pos] += 1
  pos += jump
end

puts count

# part 2

jumps = input.split("\n").map { |j| j.strip.to_i }

pos = 0
count = 0

while pos >= 0 && pos < jumps.size do
  count += 1
  jump = jumps[pos]
  if jump >= 3
    jumps[pos] -= 1
  else
    jumps[pos] += 1
  end
  pos += jump
end

puts count
