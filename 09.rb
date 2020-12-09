$nums = open('inputs/09.txt').readlines.map(&:to_i)
# $nums = DATA.readlines.map(&:to_i)

def sums_to_num_at_n n, preamble
  goal = $nums[n]
  chunk = $nums.slice(n - preamble, preamble)

  chunk.combination(2).any? { |pair| pair.sum == goal }
end

def part_1 preamble
  index = (preamble..$nums.size - 1).find { |n| ! sums_to_num_at_n(n, preamble) }

  $nums[index]
end

def part_2 goal
  s, e = (0..$nums.length).to_a.combination(2).find do |s, e|
    $nums[s...e].sum == goal
  end

  range = $nums[s...e]
  range.min + range.max
end

ans_1 = part_1 25

puts ans_1
puts part_2 ans_1

__END__
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
