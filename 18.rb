# lines = DATA.readlines(chomp: true)
lines = open('inputs/18.txt').readlines(chomp: true)

def process_symbols syms
  operator = nil
  reg = nil
  subtotal = 0

  while sym = syms.shift
    return subtotal if sym == ')'

    if sym.match? /\d/
      reg = sym.to_i
    elsif sym == '('
      reg = process_symbols syms
    elsif sym.match? /[+*]/
      operator = sym
    end

    if reg && operator
      if operator == '*'
        subtotal *= reg
      else
        subtotal += reg
      end

      operator = nil
    elsif reg
      subtotal = reg
    end

    reg = nil
  end

  subtotal
end

def answer_2 line
  line.gsub!(/\d+\+\d+/) { |m| eval(m) } while line.match?(/\d+\+\d+/)
  eval(line).to_s
end

def process_symbols_2 syms
  substr = ''

  while sym = syms.shift
    return answer_2(substr) if sym == ')'

    substr += sym == '(' ? process_symbols_2(syms) : sym
  end

  answer_2(substr).to_i
end

def process_line line, p2
  symbols = line.scan(/\d+|[+*()]/)
  if p2
    process_symbols_2 symbols
  else
    process_symbols symbols
  end
end

p lines.map { |l| process_line l, false }.sum
p lines.map { |l| process_line l, true }.sum

__END__
1 + 2 * 3 + 4 * 5 + 6
2 * 3 + (4 * 5)
5 + (8 * 3 + 9 + 3 * 4 * 3)
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
