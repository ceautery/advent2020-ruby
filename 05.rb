$lines = open('inputs/05.txt').readlines.map { |l| l.tr('FBLR', '0101').to_i(2) }.sort

puts $lines.max

puts $lines.each_with_index.find { |e, i| e + 1 != $lines[i + 1] }.first + 1
