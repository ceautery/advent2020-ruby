class Ship
  attr_accessor :pos, :direction

  DIRECTIONS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  def initialize
    @pos = [0, 0]
    @direction = 0
  end

  def N n
    pos[1] += n
  end

  def S n
    pos[1] -= n
  end

  def E n
    pos[0] += n
  end

  def W n
    pos[0] -= n
  end

  def R n
    @direction = (@direction + n / 90) % 4
  end

  def L n
    @direction = (@direction - n / 90) % 4
  end

  def F n
    dir = DIRECTIONS[direction]
    pos[0] += dir[0] * n
    pos[1] += dir[1] * n
  end

  def manhatten
    pos.map(&:abs).sum
  end
end

class Waypoint < Ship
  def initialize
    @pos = [10, 1]
  end

  def R n
    while n > 0
      x, y = pos
      @pos = [y, -x]
      n -= 90
    end
  end

  def L n
    while n > 0
      x, y = pos
      @pos = [-y, x]
      n -= 90
    end
  end

  def F n
    nil
  end
end

# $orders = DATA.readlines(chomp: true).map { |l| l.match(/([A-Z])(\d+)/).captures }
$orders = open('inputs/12.txt').readlines(chomp: true).map { |l| l.match(/([A-Z])(\d+)/).captures }

def part_1
  ship = Ship.new
  $orders.each { |f, n| ship.send(f.to_sym, n.to_i) }
  ship.manhatten
end

def part_2
  ship = Ship.new
  waypoint = Waypoint.new

  $orders.each do |order|
    command = order[0].to_sym
    count = order[1].to_i

    if command == :F
      ship.E(waypoint.pos[0] * count)
      ship.N(waypoint.pos[1] * count)
    else
      waypoint.send(command, count)
    end
  end

  ship.manhatten
end

p part_1
p part_2

__END__
F10
N3
F7
R90
F11
