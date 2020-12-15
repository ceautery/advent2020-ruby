# start = 

def speak num, round, set
  spoken = set[num].nil? ? 0 : round - set[num]
  set[num] = round
  spoken
end

def game start, end_round
  round = start.length
  set = {}

  last = 0
  start.each_with_index { |n, i| last = speak(n, i + 1, set) }

  while round < end_round - 1
    round += 1
    last = speak(last, round, set)
  end

  last
end

p game([8, 0, 17, 4, 1, 12], 2020)
p game([8, 0, 17, 4, 1, 12], 30000000)
