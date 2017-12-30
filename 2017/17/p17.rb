step = 314

# part 1

cur = 0
buffer = [0]

1.upto(2017) do |i|
  cur = (cur+step)%buffer.size + 1
  buffer.insert(cur, i)
end

puts buffer[buffer.index(2017) + 1]

# part 2

cur = 0
buffer = [0]

1.upto(50_000_000) do |i|
  cur = (cur+step)%buffer.size + 1
  buffer.insert(cur, i)
end

puts buffer[buffer.index(0) + 1]
