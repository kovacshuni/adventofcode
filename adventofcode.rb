File.open("adventofcode-input.txt", "r") do |f|
  s = 0
  f.each_line do |line|
    line = line.chomp
    puts "%s|%s|%d|%d|%d" % [line, eval(line), line.length, eval(line).length, line.length - eval(line).length]
    # puts "%d %d %d" % [line.length, eval(line).length, line.length - eval(line).length]
    s += line.length - eval(line).length
  end
  puts s
end
