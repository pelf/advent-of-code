input = File.read('input.txt')

scanners = input.split("\n").map do |scanner|
  scanner.split(':').map(&:strip).map(&:to_i)
end

# part 1
# 0 == index % ((size-1)*2)
puts scanners.select { |s| (s[0] % ((s[1] - 1)*2)).zero? }.map { |s| s[0] * s[1] }.reduce(:+)

# part 2
delay = 0

loop do
  break unless scanners.any? { |s| ((s[0]+delay) % ((s[1] - 1)*2)).zero? }
  delay += 1
end

puts delay
