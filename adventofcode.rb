require "set"

def calc_happiness_exchange(table, happiness_rules)
	result = 0
	for i in -1..table.size-2
		result = result + happiness_rules[[table[i],table[i+1]]] + happiness_rules[[table[i],table[i-1]]]
	end
	result
end

happiness_rules = Hash.new
people = Set.new

File.open("adventofcode-input.txt", "r") do |f|
	f.each_line do |line|
		match_group = /([a-zA-Z]+) would (gain|lose) (\d+) happiness units by sitting next to ([a-zA-Z]+)\./.match(line)		
		people << match_group[1]
		happiness_rules[[match_group[1],match_group[4]]] = 
		  if match_group[2]=="gain" 
			 match_group[3].to_i	
		  else
			-match_group[3].to_i
		  end	
	end
end	

people.each do |p|
	happiness_rules[[p,"me"]] = 0
	happiness_rules[["me",p]] = 0
end

people << "me"

started = false
optim = 0
people.to_a.permutation.each do |table|
	happiness = calc_happiness_exchange(table, happiness_rules)
	unless started
		started = true
		optim = happiness
	end
	if happiness > optim
		optim = happiness
	end
end

puts "Optimal exchange: %d" % [optim]