class Vector
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def to_s
    "#{x},#{y},#{z}"
  end

  def +(vector)
    Vector.new(x + vector.x, y + vector.y, z + vector.z)
  end

  def size
    x.abs + y.abs + z.abs
  end
end

class Particle
  attr_reader :id, :p, :v, :a, :destroyed

  def initialize(id, row)
    @id = id
    @destroyed = false
    parse_row row
  end

  def tick!
    @v = v + a
    @p = p + v
  end

  def destroy!
    @destroyed = true
  end

  def dist
    p.size
  end

  def accel
    a.size
  end

  private

  def parse_row(row)
    matches = row.scan(/<([^>]+)>+/).flatten
    @p = Vector.new(*matches[0].split(',').map(&:to_i))
    @v = Vector.new(*matches[1].split(',').map(&:to_i))
    @a = Vector.new(*matches[2].split(',').map(&:to_i))
  end
end

rows = File.read('input.txt').split("\n")

# part 1

particles = rows.map.with_index { |row, i| Particle.new(i, row) }
lowest_accel = particles.sort_by(&:accel).first.accel

loop do
  closest = particles.sort_by(&:dist).first
  if closest.accel == lowest_accel
    puts closest.inspect
    break
  end
  particles.each { |p| p.tick! }
end

# part 2

particles = rows.map.with_index { |row, i| Particle.new(i, row) }

loop do
  collisions = {}
  # calc collisions
  particles.each do |particle|
    next if particle.destroyed
    particle.tick!
    key = particle.p.to_s
    collisions[key] ||= []
    collisions[key] << particle
  end
  # destroy collided
  collisions.each do |_,particles|
    next unless particles.size > 1
    particles.each { |p| p.destroy! }
  end
  # too lazy to calculate stop condition
  puts particles.count { |p| !p.destroyed }
end


