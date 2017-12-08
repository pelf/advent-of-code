# ring | height | perimeter | last nr

# 1    | 1      | 1         | 1
# 2    | 3      | 8         | 9
# 3    | 5      | 16        | 25
# 4    | 7      | 24        | 49

# n    | n*2-1  | 4h - 4    | sum(p[1..n]) =
#                             p + last[n-1]

# part 1

n = 0
h = p = l = 0

loop do
  n += 1
  h = n * 2 - 1
  p = 4 * h - 4
  l = p + l
  puts "Ring #{n}: h=#{h}, p=#{p}, l=#{l}"
  break if l >= 277678
end

# got the final result with a back the envelope calculation:
# knowing the ring height and the last number, we can calculate
# that 277678 is 50 steps from the bottom right corner, and thus
# 212 steps from the vertical centre. add half the height to go
# up to square 1 and you get 475

# part 2

??
