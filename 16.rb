require 'set'

input = open('inputs/16.txt').read.split(/\n\n.+:\n/)
classes = input[0].split(/\n/).map do |l|
  name, l1, l2, r1, r2 = l.match(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/).captures
  l1 = l1.to_i
  l2 = l2.to_i
  r1 = r1.to_i
  r2 = r2.to_i
  { :name => name, :left => (l1..l2), :right => (r1..r2), :set => (l1..l2).to_set + (r1..r2).to_set }
end

valid = classes.map { |h| h[:set] }.reduce(:+)

ticket = input[1].scan(/\d+/).map(&:to_i)

tickets = input[2].split(/\n/).map { |line| line.scan(/\d+/).map(&:to_i) }

invalid = []
tickets.each { |t| t.each { |n| invalid.push(n) unless valid.include? n } }

p invalid.sum # 21996

valid_tickets = tickets.select { |t| t.all? { |n| valid.include? n } }

p classes.map { |c| [c[:name], (0...ticket.length).select { |i| valid_tickets.map { |t| t[i] }.all? { |num| c[:set].include? num } }] }

# Parse output by hand

p [2, 6, 15, 16, 17, 19].map { |n| ticket[n] }.reduce(:*) # 650080463519
