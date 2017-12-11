input = File.read('input.txt')

steps = input.split(',').map(&:strip)

# using a 3 axis coordinate system, like:
# http://www-cs-students.stanford.edu/~amitp/Articles/Hexagon2.html

posx = posy = posz = 0

max = 0

steps.each do |step|
  dx, dy, dz = case step
  when 'n'
    [0, 1, -1]
  when 'ne'
    [1, 0, -1]
  when 'se'
    [1, -1, 0]
  when 's'
    [0, -1, 1]
  when 'sw'
    [-1, 0, 1]
  when 'nw'
    [-1, 1, 0]
  end
  posx += dx
  posy += dy
  posz += dz
  max = [posx, posy, posz].max if [posx, posy, posz].max > max
end

puts [posx, posy, posz].max
puts max
