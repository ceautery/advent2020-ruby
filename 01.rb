$nums = open('inputs/01.txt').readlines.map(&:to_i)

def reducer arr, goal, parts_count
  arr.combination(parts_count).find { |set| set.sum == goal }.reduce(:*)
end

def part1
  reducer $nums, 2020, 2
end

def part2
  reducer $nums, 2020, 3
end

puts part1
puts part2
