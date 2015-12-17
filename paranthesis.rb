require 'digest'

def vowel(s)
  s.count("aeiou") >= 3
end

def double(s)
  i = 0
  while i < s.length - 1 do
   if (s[i] == s[i + 1])
     return true
   end
   i += 1
  end
  return false
end

def forbidden(s)
  f = ["ab", "cd", "pq", "xy"]
  f.each do |w|
    unless s[w].nil?
      return false
    end
  end
  return true
end

File.open("paranthesis.txt", "r") do |f|
  nice = 0
  f.each_line do |line|
    l = line[0..line.length-2]
    # puts "%s vowel %s" % [l, vowel(line)]
    # puts "%s double %s" % [l, double(line)]
    # puts "%s forbidden %s" % [l, forbidden(line)]
    if vowel(l) && double(l) && forbidden(l)
      nice += 1
    end
  end
  puts nice
end
