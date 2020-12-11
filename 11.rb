# $board = open('inputs/11.txt').readlines(chomp: true).map(&:chars)
$board = DATA.readlines(chomp: true).map(&:chars)

def neighbor_count board, row, col, first_chair
  count = 0
  (-1 .. 1).each do |dy|
    (-1 .. 1).each do |dx|
      next if dx.zero? && dy.zero?
      cell = '.'
      y = row
      x = col

      while true
        y += dy
        x += dx
        break if y < 0 || y >= board.size
        break if x < 0 || x >= board[y].size

        cell = board[y][x]
        break unless cell == '.' && first_chair
      end

      count += 1 if cell == '#'
    end
  end

  count
end

def round board, crowded, first_chair
  clone = []
  changed = false

  board.each_with_index do |line, row|
    clone[row] = line.each_with_index.map do |char, col|
      n = neighbor_count board, row, col, first_chair
      if n == 0 && char == 'L'
        changed = true
        '#'
      elsif n > crowded && char == '#'
        changed = true
        'L'
      else
        char
      end
    end
  end

  [clone, changed]
end

def game(crowded, first_chair)
  status = true
  board = $board.map(&:dup)

  board, status = round(board, crowded, first_chair) while status

  board.join.count('#')
end

def part_1
  game(3, false)
end

def part_2
  game(4, true)
end

p part_1
p part_2

__END__
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
