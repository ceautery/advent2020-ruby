$instructions = open('inputs/14.txt').readlines(chomp: true)

def apply_mask val, mask
  a = mask.gsub('X', '1').to_i(2)
  o = mask.gsub('X', '0').to_i(2)
  val & a | o
end

def decode_addresses val, mask
  indices = (0...mask.length).select { |i| mask[i] == 'X' }
  sets = (0..indices.size).map {|x| indices.combination(x).to_a}.flatten(1)
  base_addr = (mask.gsub('X', '0').to_i(2) | val).to_s(2).rjust(mask.length, '0')
  indices.each { |i| base_addr[i] = '0' }
  sets.map do |indices|
    m = base_addr.dup
    indices.each { |i| m[i] = '1' }
    m.to_i(2)
  end
end

def run
  mask = ''

  $instructions.each do |line|
    if line.start_with? 'mask'
      mask = line.match(/[X10]+/).to_s
    elsif line.start_with? 'mem'
      addr, val = line.match(/(\d+).+?(\d+)/).captures.map(&:to_i)
      yield addr, mask, val
    end
  end
end

def part_1
  mem = []
  run { |addr, mask, val| mem[addr] = apply_mask val, mask }
  mem.compact.sum
end

def part_2
  mem = {}
  run do |addr, mask, val|
    decode_addresses(addr, mask).each { |addr| mem[addr] = val }
  end
  mem.values.sum
end

p part_1
p part_2
