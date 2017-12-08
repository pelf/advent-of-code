input = File.read('input.txt')
@banks = input.split.map { |b| b.to_i }

def highest_index
  @banks.index @banks.max
end

def hash
  @banks.map { |b| b.to_s.rjust(3, '0') }.join
end

def distribute(index)
  count = @banks[index]
  @banks[index] = 0
  count.times { @banks[(index+=1) % @banks.size] += 1 }
end

seen = {}
count = 0

loop do
  h = hash
  break if seen[h]
  seen[h] = true
  count += 1

  distribute(highest_index)
end

puts count

# part 2

seen = hash
count = 0

loop do
  count += 1
  distribute(highest_index)
  break if seen == hash
end

puts count
