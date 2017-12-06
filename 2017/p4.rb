input = File.read('./inputs/4.txt')
passphrases = input.split("\n")

# part 1

def valid?(passphrase)
  words = passphrase.split
  words.uniq.size == words.size
end

puts passphrases.select { |p| valid? p }.size

# part 2

def valid?(passphrase)
  seen = {}
  words = passphrase.split
  words.each do |word|
    sorted_word = word.chars.sort.join
    return false if seen[sorted_word]
    seen[sorted_word] = true
  end
  return true
end

puts passphrases.select { |p| valid? p }.size
