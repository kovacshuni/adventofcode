require 'set'

distances = Hash.new
cities = Set.new

File.open("adventofcode-input.txt", "r") do |f|
  f.each_line do |line|
    line = line.chomp
    matchdata = line.match(/(\w+) to (\w+) = (\d+)/)
    # puts "%s - %s = %d" % [matchdata[1], matchdata[2], matchdata[3]]
    cities << matchdata[1]
    cities << matchdata[2]
    ab = [ matchdata[1], matchdata[2] ]
    ba = [ matchdata[2], matchdata[1] ]
    distances[ab] = matchdata[3].to_i
    distances[ba] = matchdata[3].to_i
  end
end


citiesa = cities.to_a
mins = Array.new
citiesa.permutation.to_a.each do |route|
  s = 0
  for i in 0..route.length - 2
    s += distances[[route[i], route[i+1]]]
  end
  mins << s
end

puts mins.min
puts mins.max

# cities.each do |c1|
#   min = 255
#   started = false
#   cities.each do |c2|
#     unless started
#       min = distances[[c1, c2]]
#     end
#     if c1 != c2
#       if distances[[c1, c2]] < min
#         min = distances[[c1, c2]]
#       end
#     end
#   end
#   puts "shortest from %s is %d" % [c1, min] 
# end