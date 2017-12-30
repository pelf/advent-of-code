@rows = File.read('input.txt').split("\n")

dirs = [:s, :w, :n, :e]
@dir = :s
@row = 0
@col = @rows.first.index('|')
@steps = 0

def next_pos
  case @dir
  when :s
    return @row + 1, @col
  when :w
    return @row, @col - 1
  when :n
    return @row - 1, @col
  when :e
    return @row, @col + 1
  end
end

def next_dir
  case @dir
  when :s, :n
    if @rows[@row][@col+1] == '-'
      return :e
    else
      return :w
    end
  when :w, :e
    if @rows[@row+1][@col] == '|'
      return :s
    else
      return :n
    end
  end
end

def turn!
  @dir = next_dir
end

def move!
  @row, @col = next_pos
  @steps += 1
end

def next_val
  row, col = next_pos
  @rows[row][col]
end


loop do
  pipe = @rows[@row][@col]
  case pipe
  when '|', '-'
    move!
  when '+'
    turn!
    move!
  when ' '
    break
  else
    print pipe
    move!
  end
end

puts ''

# part 2
puts @steps
