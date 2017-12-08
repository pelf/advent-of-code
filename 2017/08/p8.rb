ops = File.readlines('input.txt')

regs = Hash.new(0)
max = 0

ops.each do |op|
  op, cond = op.split(' if ')
  op_reg, op, op_val = op.split
  cond_reg, cond_op, cond_val = cond.split
  if eval("#{regs[cond_reg]} #{cond_op} #{cond_val}")
    regs[op_reg] += op_val.to_i if op == 'inc'
    regs[op_reg] -= op_val.to_i if op == 'dec'
    max = regs[op_reg] if regs[op_reg] > max
  else
    regs[op_reg] += 0 # force this reg's creation
  end
end

# part 1
puts regs.sort{|a,b| b[1]<=>a[1]}.first

# part 2
puts max
