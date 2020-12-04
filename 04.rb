def fields record
  hash = {}
  record.split(/\s+/).each do |f|
    match = f.split(':')
    hash[match[0]] = match[1]
  end

  hash
end

# $records = DATA.read.split("\n\n").map { |r| fields r }
$records = open('inputs/04.txt').read.split("\n\n").map { |r| fields r }

def valid_1 record
  %w(byr iyr eyr hgt hcl ecl pid) - record.keys == []
end

def valid_2 record
  return false unless valid_1 record

  valid_byr(record) &&
    valid_iyr(record) &&
    valid_eyr(record) &&
    valid_hgt(record) &&
    valid_hcl(record) &&
    valid_ecl(record) &&
    valid_pid(record)
end

def valid_year y, min, max
  y.match?(/^\d{4|$/) && y.to_i.between?(min, max)
end

def valid_byr r
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  valid_year(r['byr'], 1920, 2002)
end

def valid_iyr r
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  valid_year(r['iyr'], 2010, 2020)
end

def valid_eyr r
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  valid_year(r['eyr'], 2020, 2030)
end

def valid_hgt r
  # hgt (Height) - a number followed by either cm or in:
  #   If cm, the number must be at least 150 and at most 193.
  #   If in, the number must be at least 59 and at most 76.
  h = r['hgt']
  return false unless h.match?(/^\d+(cm|in)$/)

  h.end_with?('cm') ? h.to_i.between?(150, 193) : h.to_i.between?(59, 76)
end

def valid_hcl r
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  r['hcl'].match? /^#[0-9a-f]{6}$/
end

def valid_ecl r
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  %w(amb blu brn gry grn hzl oth).include? r['ecl']
end

def valid_pid r
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  r['pid'].match?(/^\d{9}$/)
end

def part1
  $records.count { |r| valid_1 r }
end

def part2
  $records.count { |r| valid_2 r }
end

puts part1
puts part2

__END__
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
