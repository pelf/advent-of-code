@input = File.read('input.txt')

@score = 0

def parse_group(start = 0, score = 1)
  raise unless @input[start] == '{'
  pos = start
  loop do
    pos += 1
    case @input[pos]
    when '!'
      pos += 1 # skip next char
    when '{'
      pos, s = parse_group(pos, score + 1) # nested group
      @score += s
    when '<'
      pos = parse_trash(pos)
    when '}'
      return pos, score
    end
  end
end

def parse_trash(start)
  raise unless @input[start] == '<'
  pos = start
  loop do
    pos += 1
    case @input[pos]
    when '!'
      pos += 1 # skip next char
    when '>'
      return pos
    end
  end
end

# part 1
_, score = parse_group
@score += score

puts @score

# part 2

def parse_trash(pos = 0)
  count = 0
  loop do
    pos += 1
    return count if pos == @input.size
    case @input[pos]
    when '!'
      pos += 1
    when '<'
      pos, c = count_trash(pos)
      count += c
    end
  end
end

def count_trash(pos)
  count = 0
  loop do
    pos += 1
    case @input[pos]
    when '!'
      pos += 1
    when '>'
      return pos, count
    else
      count += 1
    end
  end
end

puts parse_trash
