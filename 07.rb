$bags = {}

def bag name
  $bags[name] = { parents: [], children: [] } unless $bags[name]
  $bags[name]
end

def all_parents name
  b = bag(name)
  parents = b[:parents]
  (parents + parents.map { |p| all_parents(p) }).flatten.uniq
end

def all_children name
  b = bag(name)
  children = []
  b[:children].each do |count, child|
    count.times do
      children.append child
      children.append all_children(child)
    end
  end

  children.flatten
end

# DATA.readlines.each do |line|
open('inputs/07.txt').readlines.each do |line|
  name = line.match(/\w+ \w+/).to_s
  children = line.scan(/(\d) (\w+ \w+)/)
  b = bag(name)

  children.each do |count, child|
    c = bag(child)
    c[:parents].push name
    b[:children].push([count.to_i, child])
  end
end

def part_1
  all_parents('shiny gold').size
end

def part_2
  all_children('shiny gold').size
end

puts part_1
puts part_2


__END__
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
