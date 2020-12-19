rule_lines, input = open('inputs/19.txt').read.split(/\n\n/).map { |blob| blob.split /\n/ }
rules = {} # Hash, so I don't have to monkey around with .to_i and .to_s conversions everywhere

rule_lines.each do |line|
  idx, rule = line.split /: /
  rules[idx] = rule
end

def build_regex rules
  re = "^#{rules['0']}$"
  while true
    nums = re.scan /\d+/
    break if nums.length.zero?

    nums.each { |num| re.gsub!(/\b#{num}\b/, "(#{rules[num]})") }
  end

  re.gsub! /[" ]/, ''
end

# part 1
re = build_regex rules
puts input.count { |line| line.match? /#{re}/ }

# part 2
rules['8'] = "42+"
# Recursive named subexpression matching: https://docs.ruby-lang.org/en/2.0.0/Regexp.html#class-Regexp-label-Subexpression+Calls
rules['11'] = "(?<e>42 \\g<e>* 31)+"

re = build_regex rules
puts input.count { |line| line.match? /#{re}/ }
