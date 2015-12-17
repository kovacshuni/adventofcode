require 'pry'

class Lights

  def initialize(size)
    @@size = size
    @@lights = Array.new(size) { Array.new(size) {0} }
    turn_off(0, size-1, 0, size-1)
  end
  
  def turn_off(x1, y1, x2, y2)
    for j in y1..y2
      for i in x1..x2
        unless @@lights[j][i] <= 0
          @@lights[j][i] -= 1
        end
      end
    end 
  end
  
  def turn_on(x1, y1, x2, y2)
    for j in y1..y2
      for i in x1..x2
        @@lights[j][i] += 1
      end
    end 
  end
  
  def printt()
    for j in 0..@@size-1
      for i in 0..@@size-1
        e = @@lights[j][i]
        print "%d " % [ e ]
      end
      puts
    end
  end
  
  def toggle(x1, y1, x2, y2)
    for j in y1..y2
      for i in x1..x2
        @@lights[j][i] += 2
      end
    end 
  end
  
  def count()
    s = 0
    for j in 0..@@size-1
      for i in 0..@@size-1
        s += @@lights[j][i]
      end
    end
    return s
  end
  
end

File.open("paranthesis.txt", "r") do |f|
  lights = Lights.new(1000)
  f.each_line do |line|
    matchdata = /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/.match(line)  
    case matchdata[1]
      when "turn on"
        lights.turn_on(matchdata[2].to_i, matchdata[3].to_i, matchdata[4].to_i, matchdata[5].to_i)
      when "turn off"
        lights.turn_off(matchdata[2].to_i, matchdata[3].to_i, matchdata[4].to_i, matchdata[5].to_i)
      when "toggle"
        lights.toggle(matchdata[2].to_i, matchdata[3].to_i, matchdata[4].to_i, matchdata[5].to_i)
    end
  end
  puts lights.count()
  # puts "end"
  # lights.printt()
end
