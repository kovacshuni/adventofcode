require 'set'
require "readline"

# x -> w
def direct(w, x) 
  instance_variable_set(w, x)
  return true
end

# w1 -> w2
def wire_to_wire(w1, w2) 
  if eval(w1).nil?
    return false
  end
  instance_variable_set(w2, eval(w1))
  return true
end

# a OP b -> c
def binary(a, op, b, c)
  aa =
    if /[a-zA-Z]/.match(a).nil?
      a.to_i
    else
      @vars << '@'+a
      if eval('@'+a).nil?
        return false
      end
      eval('@'+a)
    end
    
  bb =
    if /[a-zA-Z]/.match(b).nil?
      b.to_i
    else
      @vars << '@'+b
      if eval('@'+b).nil?
        return false
      end
      eval('@'+b)
    end
  
  case op
  when 'AND'
    instance_variable_set(c, aa & bb)
  when 'OR'
    instance_variable_set(c, aa | bb)
  end
  return true
end

# a SHIFT b -> c
def shift(a, s, b, c)
  if eval(a).nil?
    return false
  end
  
  case s
  when 'LSHIFT'
    instance_variable_set(c, eval(a) << b)
  when 'RSHIFT'
    instance_variable_set(c, eval(a) >> b)
  end
  return true
end

# NOT a -> b
def notf(a, b)
  if eval(a).nil?
    return false
  end

  instance_variable_set(b, ~eval(a))
  return true
end

def one_parse(line)
  direct_matchdata = /^(\d+) -> ([a-zA-Z]+)$/.match(line)
  wire_to_wire_matchdata = /^([a-zA-Z]+) -> ([a-zA-Z]+)$/.match(line)
  binary_matchdata = /(\w+) (AND|OR) (\w+) -> ([a-zA-Z]+)/.match(line)
  shift_matchdata = /([a-zA-Z]+) (LSHIFT|RSHIFT) (\d+) -> ([a-zA-Z]+)/.match(line)
  not_matchdata = /NOT ([a-zA-Z]+) -> ([a-zA-Z]+)/.match(line)
  
  if !direct_matchdata.nil?
    # puts "signal %d assigned to wire %s" % [direct_matchdata[1].to_i, direct_matchdata[2]]
    direct('@' + direct_matchdata[2], direct_matchdata[1].to_i) 
    @vars << '@' + direct_matchdata[2] 
    @evaluated << '@' + direct_matchdata[2] 
  elsif !wire_to_wire_matchdata.nil?
    # puts "wire %s assigned to wire %s" % [wire_to_wire_matchdata[1], wire_to_wire_matchdata[2]]
    @vars << '@' + wire_to_wire_matchdata[1] 
    @vars << '@' + wire_to_wire_matchdata[2] 
    if wire_to_wire('@' + wire_to_wire_matchdata[1], '@' + wire_to_wire_matchdata[2])
      @evaluated << '@' + wire_to_wire_matchdata[2]
    end
  elsif !binary_matchdata.nil?  
    # puts "wire %s and %s by function %s to %s" % [binary_matchdata[1], binary_matchdata[3], binary_matchdata[2], binary_matchdata[4]]
    @vars << '@' + binary_matchdata[4] 
    if binary(binary_matchdata[1], binary_matchdata[2], binary_matchdata[3], '@'+binary_matchdata[4])
      @evaluated << '@' + binary_matchdata[4]
    end
  elsif !shift_matchdata.nil?
    # puts "wire %s shifted %s by %s goes to wire %s" % [shift_matchdata[1], shift_matchdata[2], shift_matchdata[3], shift_matchdata[4]]
    @vars << '@' + shift_matchdata[1]
    @vars << '@' + shift_matchdata[4] 
    if shift('@'+shift_matchdata[1], shift_matchdata[2], shift_matchdata[3].to_i, '@'+shift_matchdata[4])
      @evaluated << '@' + shift_matchdata[4]
    end
  elsif !not_matchdata.nil?
    # puts "wire %s is opposite of %s" % [not_matchdata[1], not_matchdata[2]]
    @vars << '@' + not_matchdata[1]
    @vars << '@' + not_matchdata[2] 
    if notf('@'+not_matchdata[1], '@'+not_matchdata[2])
      @evaluated << '@' + not_matchdata[2]
    end
  else
    puts "error parsing %s" % [line]
  end
end

@vars = Set.new
@evaluated = Set.new
lines = Array.new

File.open("adventofcode-input.txt", "r") do |f|
  f.each_line do |line|
    lines << line
  end
end

begin
  lines.each do |line|
    one_parse(line)
  end
  # puts 'evaluated'
  # @evaluated.each { |var| puts "%s = %d" % [var, eval(var)] }
  # Readline.readline("> ", true)
  # break
end while !@evaluated.include?('@a')

# puts 'vars'
# @vars.each { |var| puts var }

puts 'evaluated'
@evaluated.each { |var| puts "%s = %d" % [var, eval(var)] }
puts @a
