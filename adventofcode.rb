
def look_and_say(a)
  n = 1
  res = Array.new
  for i in 0..a.length
    if a[i+1] == a[i]
      n += 1
    else
      res << n
      res << a[i]
      n = 1
    end
  end
  res
end

File.open("adventofcode-input.txt", "r") do |f|
  f.each_line do |line|
    line = line.chomp
    a = line.split("").map{|c| c.to_i}
    for i in 1..50
      t1 = Time.now.to_i
      a = look_and_say(a)
      puts "%d. iteration calculated in %ds. Length was %d." % [i, Time.now.to_i - t1, a.length]
    end
  end
end
