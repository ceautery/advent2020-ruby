$pgm = open('inputs/08.txt').readlines.map { |line| op, val = line.split ' '; [op, val.to_i] }

def score
  visited = []
  pos = 0
  acc = 0

  while true
    break if visited[pos]

    delta = 1
    visited[pos] = true
    op, val = $pgm[pos]
    if op == 'acc'
      acc += val
    elsif op == 'jmp'
      delta = val
    end

    pos += delta
    return [acc, true] if pos >= $pgm.size
  end

  [acc, false]
end

def find_bug
  pos = 0
  while true
    if $pgm[pos].first == 'nop'
      $pgm[pos][0] = 'jmp'
      acc, exited = score
      return acc if exited

      $pgm[pos][0] = 'nop'
    elsif $pgm[pos].first == 'jmp'
      $pgm[pos][0] = 'nop'
      acc, exited = score
      return acc if exited

      $pgm[pos][0] = 'jmp'
    end

    pos += 1
  end
end

puts score.first

puts find_bug
