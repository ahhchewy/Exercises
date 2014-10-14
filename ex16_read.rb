filename = ARGV.first

txt = open(filename)

puts "Here is your file #{filename}:"
print txt.read

txt.close