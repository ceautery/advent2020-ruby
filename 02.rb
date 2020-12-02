# $lines = DATA.readlines
$lines = open('inputs/02.txt').readlines

def fields line
  min, max, char, psw = line.match(/(\d+)-(\d+) ([a-z]): ([a-z]+)/).captures
  [min.to_i, max.to_i, char, psw]
end

def valid_p1 line
  min, max, char, psw = fields line
  count = psw.count char
  count.between? min, max
end

def valid_p2 line
  pos1, pos2, char, psw = fields line
  (psw[pos1 - 1] == char) ^ (psw[pos2 - 1] == char)
end

puts $lines.count { |line| valid_p1(line) }
puts $lines.count { |line| valid_p2(line) }

__END__
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
