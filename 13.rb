# input = DATA.readlines
input = open('inputs/13.txt').readlines

$start = input[0].to_i
$busses = input[1].scan(/\d+/).map(&:to_i)
$positions = input[1].split(',').each_with_index.reject { |t, i| t == 'x' }.map(&:last)

def part_1
  time = ($start..).find { |t| $busses.any? { |n| (t % n).zero? } }
  bus = $busses.find { |n| (time % n).zero? }
  (time - $start) * bus
end

def part_2
  # Poor man's Chinese Remainder theorem. See http://cautery.blogspot.com/2012/06/rsa-encryption-and-other-sun-tzu.html
  remainders = $busses.zip($positions).map { |bus, pos| bus - (pos % bus) }
  product = $busses.reduce(:*)

  multiples = $busses.map do |num|
    base = product / num
    multiplier = (1..).find { |n| (n * base) % num == 1 }
    multiplier * base
  end

  multiples.each_with_index.map { |m, i| m * remainders[i] }.sum % product
end

p part_1
p part_2

__END__
939
7,13,x,x,59,x,31,19
