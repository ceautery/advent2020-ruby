$nums = open('inputs/01.txt').readlines.map(&:to_i)

def part1
  pair = $nums.combination(2).find { |p| p.sum == 2020 }
  pair.reduce(:*)
end

def part2
  pair = $nums.combination(3).find { |p| p.sum == 2020 }
  pair.reduce(:*)
end

puts part1
puts part2
