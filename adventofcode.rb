require 'yaml'

def escape(s)
  s.inspect
end

File.open("adventofcode-input.txt", "r") do |f|
  s = 0
  ors = 0
  es = 0
  f.each_line do |line|
    line = line.chomp
    puts "%s|%s|%d|%d|%d" % [line, escape(line), line.length, escape(line).length, escape(line).length - line.length]
    ors += line.length
    es += escape(line).length
    s += escape(line).length - line.length
  end
  puts ors
  puts es
  puts es - ors
  puts s
end
