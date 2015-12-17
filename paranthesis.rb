require 'digest'

def double(s)
  i = 0
  while i < s.length - 1 do
    j = 0
    while j < s.length - 1 do
      if j + 1 < i || j > i + 1      
        if (s[i..i + 1] == s[j..j + 1])
          return true
        end
      end
      j += 1
    end
   i += 1
  end
  return false
end

def repeat(s)
  i = 0
  while i < s.length - 2 do
    if (s[i] == s[i + 2])
      return true
    end
    i += 1
  end
  return false
end

File.open("paranthesis.txt", "r") do |f|
  nice = 0
  f.each_line do |line|
    l = line[0..line.length-2]
    puts "%s double %s" % [l, double(line)]
    puts "%s repeat %s" % [l, repeat(line)]
    if double(l) && repeat(l)
      nice += 1
    end
  end
  puts nice
end
