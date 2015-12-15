require 'digest'

def starts_with_00000(hash)
  first5 = hash.to_s[0..4]
  # puts first5
  hash.to_s[0..4] == "00000"
end

def starts_with_000000(hash)
  first5 = hash.to_s[0..5]
  # puts first5
  hash.to_s[0..5] == "000000"
end

def hash_it(base, n)
  key = base.to_s + n.to_s
  hash = Digest::MD5.hexdigest(key)
  return hash
end

File.open("paranthesis.txt", "r") do |f|
  f.each_line do |line|
    i = 0
    hash = 0
    begin 
      hash = hash_it(line, i)
      # puts hash
      i += 1
    end while (!starts_with_000000(hash))
    puts i - 1
    puts hash
  end
end

puts hash_it("pqrstuv", 1048970)
puts hash_it("abcdef", 609043)
# && i < 10