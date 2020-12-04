require 'active_model'

class Passport
  include ActiveModel::Model

  attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid
  validates_presence_of :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid
end

class StrictPassport < Passport
  validates_each :byr, :iyr, :eyr do |record, attr, value|
    record.errors.add(attr) if value !~ /\A\d{4}\z/
  end
  validate :valid_byr, :valid_iyr, :valid_eyr, :valid_hgt
  validates :hcl, format: { with: /\A#[0-9a-f]{6}\z/ }
  validates :ecl, inclusion: { in: %w(amb blu brn gry grn hzl oth) }
  validates :pid, format: { with: /\A\d{9}\z/ }

  def valid_byr
    errors.add(:byr) unless byr.to_i.between?(1920, 2002)
  end

  def valid_iyr
    errors.add(:iyr) unless iyr.to_i.between?(2010, 2020)
  end

  def valid_eyr
    errors.add(:eyr) unless eyr.to_i.between?(2020, 2030)
  end

  def valid_hgt
    if hgt =~ /\A\d+cm\z/
      errors.add(:hgt, 'out of range') unless hgt.to_i.between?(150, 193)
    elsif hgt =~ /\A\d+in\z/
      errors.add(:hgt, 'out of range') unless hgt.to_i.between?(59, 76)
    else
      errors.add(:hgt, 'wrong format')
    end
  end
end

def fields record
  Hash[record.scan(/(\w+):(\S+)/)]
end

# $records = DATA.read.split("\n\n").map { |r| fields r }
$records = open('inputs/04.txt').read.split("\n\n").map { |r| fields r }

def part1
  $records.map { |r| Passport.new(r) }.count(&:valid?)
end

def part2
  $records.map { |r| StrictPassport.new(r) }.count(&:valid?)
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
