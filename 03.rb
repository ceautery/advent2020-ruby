# $lines = DATA.readlines(chomp: true)
$lines = open('inputs/03.txt').readlines(chomp: true)

def count_trees vector
  x = 0
  y = 0
  count = 0
  w = $lines[0].length

  while true
    count += 1 if $lines[y][x % w] == '#'
    x += vector[0]
    y += vector[1]
    break if y >= $lines.length
  end

  count
end

def part1
  count_trees([3, 1])
end

def part2
  [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map { |v| count_trees v }.reduce(:*)
end

puts part1
puts part2

__END__
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
