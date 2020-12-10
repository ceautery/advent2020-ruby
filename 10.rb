adapters = open('inputs/10.txt').readlines.map(&:to_i).sort
$jolts = [0] + adapters + [adapters.max + 3]

def part_1
  diffs = $jolts[1..].each_with_index.map { |num, index| num - $jolts[index] }

  diffs.count(1) * diffs.count(3)
end

def part_2
  friends = $jolts.each_with_index.map do |adapter, index|
    [adapter, $jolts[index + 1, 3].select { |a| a <= adapter + 3 }]
  end

  scores = []

  friends.reverse.each do |adapter, set|
    scores[adapter] = set.size.zero? ? 1 : set.map { |friend| scores[friend] }.sum
  end

  scores.first
end

p part_1
p part_2
