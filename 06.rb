require 'set'

$groups = open('inputs/06.txt').read.split /\n\n/

def part1
  $groups.map { |g| g.scan(/[a-z]/).to_set.size }.sum
end

def part2
  $groups.map { |group| ('a'..'z').count { |char| group.split(/\n/).all? { |line| line.include? char } } }.sum
end

puts part1
puts part2
