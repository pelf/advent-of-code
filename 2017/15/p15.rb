MULT_A = 16807
MULT_B = 48271
DIV = 2147483647

def prng(p, mult)
  n = (p * mult) % DIV
end

def bin16(n)
  n & 65535 # .to_i.to_s(2).rjust(32, '0')[16,32]
end

a = 679
b = 771

# part 1

matches = 0

40_000_000.times do
  a = prng a, MULT_A
  b = prng b, MULT_B
  matches += 1 if bin16(a) == bin16(b)
end

puts matches

# part 2

a = 679
b = 771

matches = 0

5_000_000.times do
  loop do
    a = prng a, MULT_A
    break if a % 4 == 0
  end
  loop do
    b = prng b, MULT_B
    break if b % 8 == 0
  end
  matches += 1 if bin16(a) == bin16(b)
end

puts matches
