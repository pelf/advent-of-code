require 'pry'

input = File.read('input.txt')

ops = input.split("\n")

# if given an int, returns it. otherwise returns the value in the register
def val(v)
  v =~ /\d/ ? v.to_i : @mem[v]
end

@mem = Hash.new(0)

freq = nil
cur = 0

loop do
  op = ops[cur]
  op =~ /(\w+)\s+([^\s]+)\s*(.*)/
  op, x, y = $1, $2, $3
  case $1
  when /snd/
    # play sound?
    freq = @mem[x]
  when /set/
    @mem[x] = val(y)
  when /add/
    @mem[x] += val(y)
  when /mul/
    @mem[x] *= val(y)
  when /mod/
    @mem[x] %= val(y)
  when /rcv/
    (puts freq; break) if val(x) > 0
  when /jgz/
    (cur += (val(y) - 1)) if val(x) > 0
  end
  cur += 1
  break if cur >= ops.size
end
