class Game


	def initialize(room_map)

		@quips = [
			"Hopefully you get reincarnated as rock, you might do better.",
			"You had one job!",
			"I guess it's THAT kind of day.",
			"Death is very becoming of you!"
		]

		@direction = ['right', 'left', 'straight', 'turn around']

		@misdirection = "Not knowing a direction to go in, you run around in a circle."

		@wall = "Ouch! You walked into a wall!"

		@room_map = room_map
		@previous_room = @room_map
		@orientation = nil
	end

	def play()
		@next_room = @room_map

		while true
			puts "\n--------------------"
			room = method(@next_room)
			@next_room = room.call()
		end
	end

	def prompt
		print "> "
	end

	def compare(input)
		@direction.any? {|x| x == input}
	end

	def go(room1=nil, room2=nil, room3=nil, room4=nil)

		if @orientation == 'right'
			return room1
		elsif @orientation == 'left'
			return room2
		elsif @orientation == 'straight'
			return room3
		elsif @orientation == 'turn around'
			return room4
		else
			puts 'No direction or room was defined for this action.'
		end
	end

	def death()
		puts
		puts "You have died..."
		puts @quips[rand(0..(@quips.length - 1))]
		puts
		exit(1)
	end

	def inside_mouse_hole()

		puts "You are a hungry mouse, looking for food."
		puts "Your vision is poor, but you make your way to a well lit house."
		puts "Managing to squeeze through a big crack in the side, and end up in the walls."
		puts "You see a light! It is a hole to the inside of the house!"
		puts "You might be able to find some food."
		puts "Do you approach the hole?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'yes' || user_input != 'no'

			if user_input == 'yes'
				puts "Carefully, you make your way to the entrance of the mouse hole."
				return :mouse_hole
			elsif user_input == 'no'
				return :death
			else
				puts "Think a little harder, you are starving and are not thinking straight."
				prompt
				user_input = $stdin.gets.chomp.downcase
			end 

		end
	end

	def mouse_hole()

		puts "At the entrance of the mouse hole."
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'straight' || user_input != 'turn around'

			if user_input == 'straight' || user_input == 'turn around'
				@orientation = user_input
				puts @previous_room
				puts @orientation

				if @previous_room == :inside_mouse_hole
					puts "This worked!"
					go(nil, nil, :hallway1, :death)
				elsif @previous_room == :hallway1
					go(nil, nil, :death, :hallway1)
				else
					puts 'Room not defined.'
				end

			elsif user_input == 'right' || user_input == 'left'
				puts @wall
			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end

		@previous_room = :mouse_hole

	end

	def hallway_1()
		puts @previous_room
		puts
		puts "Hallway1"
	end



class Hallway2

	def enter()
		puts "Hallway2"
	end
end


class Livingroom

	def enter()
		puts "Hallway3"
	end
end


class DeadEnd

	def enter()
		puts "DeadEnd"
	end
end


class Door
	def enter()
		puts "Door"
	end
end


class Kitchen

	def enter()
		puts "Kitchen"
	end
end


class Stairs

	def enter()
		puts "Stairs"
	end
end


class TopStairs

	def enter()
		puts "TopStairs"
	end
end


class Hallway3

	def enter()
		puts "Hallway3"
	end
end


class GirlBedroom

	def enter()
		puts "GirlBedroom"
	end
end


class Banister
	def enter()
		puts "Banister"
	end
end


class Bathroom

	def enter()

	end
end


class MasterBedroom

	def enter()
		puts "MasterBedroom"
	end
end


class Kitchen

	def enter()
		puts "Kitchen"
	end
end


class InnerKitchen

	def enter()
		puts "InnerKitchen"
	end
end


class Finished

	def enter()
		puts "You found the cheese! You won!"
		puts "You will not starve!"
	end
end

end


a_game = Game.new(:inside_mouse_hole)
a_game.play()