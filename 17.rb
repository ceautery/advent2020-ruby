class Cell
  attr_reader :x, :y, :z, :w, :id
  attr_accessor :active

  def initialize x, y, z, w, active
    @x = x
    @y = y
    @z = z
    @w = w
    @active = active
    @id = "#{x},#{y},#{z},#{w}"
  end

  def neighbors
    n = []
    (w - 1 .. w + 1).each do |w|
      (z - 1 .. z + 1).each do |z|
        (y - 1 .. y + 1).each do |y|
          (x - 1 .. x + 1).each do |x|
            n.push "#{x},#{y},#{z},#{w}"
          end
        end
      end
    end

    n.delete id
    n
  end

end

$cells = {}
# lines = DATA.readlines(chomp: true)
lines = open('inputs/17.txt').readlines(chomp: true)

lines.each_with_index do |line, x|
  line.chars.each_with_index do |c, y|
    $cells["#{x},#{y},0,0"] = Cell.new(x, y, 0, 0, true) if c == '#'
  end
end

def cell_at id
  if $cells[id].nil?
    x, y, z, w = id.split(/,/).map(&:to_i)
    $cells[id] = Cell.new(x, y, z, w, false)
  end

  $cells[id]
end

def active_neighbor_count cell
  ids = cell.neighbors
  an = $cells.values.select { |c| c.active && ids.include?(c.id) }
  an.count
end

def active_next cell
  count = active_neighbor_count cell
  count == 3 || (cell.active && count == 2)
end

def round
  cells = {}
  look_at = $cells.values.select(&:active).map(&:neighbors).flatten.uniq.map{ |id| cell_at id }
  look_at.each { |cell| cells[cell.id] = cell if active_next(cell) }
  cells.values.each { |cell| cell.active = true }
  $cells = cells
end

6.times { round }
p $cells.count

__END__
.#.
..#
###
