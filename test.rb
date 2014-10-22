misdirection = {
	:wall => "You've walked into a wall.",
	:confused => "Not knowing a direction to go in, you run around in a circle.",
}

def comparison(input)
	direction = ['right', 'left', 'straight', 'turn around']
	direction.any? {|x| x == input}
end

puts "At the entrance of the mouse hole."
print "> "

user_input = $stdin.gets.chomp.downcase

while !comparison(user_input)
	if comparison(user_input)
	puts "This works"
else
	puts "Nope, dosen't work"
end
	puts misdirection[:confused]
	print "> "
	user_input = $stdin.gets.chomp.downcase
end
