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

				if @previous_room == :inside_mouse_hole

					@previous_room = :mouse_hole
					 
					 if user_input == 'straight'
					 	return :hallway_1
					 elsif user_input == 'turn around'
					 	return :death
					 else
					 	puts "Was not able to proceed to the next room."
					 end

				elsif @previous_room == :hallway_1

					@previous_room = :mouse_hole

					 if user_input == 'straight'
					 	return :death
					 elsif user_input == 'turn around'
					 	return :hallway_1
					 else
					 	puts "Was not able to proceed to the next room."
					 end

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
	end

	def hallway_1()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Hallway1"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'right' || user_input != 'left' || user_input != 'straight' || user_input != 'turn around'

			if user_input == 'right' || user_input == 'left' || user_input == 'straight' || user_input == 'turn around'

				if @previous_room == :mouse_hole

					@previous_room = :hallway_1

					if user_input == 'right'
						return :hallway_2
					elsif user_input == 'left'
						return :stairs
					elsif user_input == 'straight'
						puts @wall
						@previous_room = :mouse_hole
					elsif user_input == 'turn around'
						return :mouse_hole
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :stairs

					@previous_room = :hallway_1

					if user_input == 'right'
						return :mouse_hole
					elsif user_input == 'left'
						puts @wall
						@previous_room = :stairs
					elsif user_input == 'straight'
						return :hallway_2
					elsif user_input == 'turn around'
						return :stairs
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :hallway_2

					@previous_room = :hallway_1

					if user_input == 'right'
						puts @wall
						@previous_room = :hallway_2
					elsif user_input == 'left'
						return :mouse_hole
					elsif user_input == 'straight'
						return :hallway_1
					elsif user_input == 'turn around'
						return :stairs
					else
						puts "Was not able to proceed to the next room."
					end
				end
			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def hallway_2()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Hallway2"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'right' || user_input != 'left' || user_input != 'straight' || user_input != 'turn around'

			if user_input == 'right' || user_input == 'left' || user_input == 'straight' || user_input == 'turn around'

				if @previous_room == :hallway_1

					@previous_room = :hallway_2

					if user_input == 'right'
						return :livingroom
					elsif user_input == 'left'
						return :kitchen
					elsif user_input == 'straight'
						return :dead_end
					elsif user_input == 'turn around'
						return :hallway_1
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :livingroom

					@previous_room = :hallway_2

					if user_input == 'right'
						return :dead_end
					elsif user_input == 'left'
						return :hallway_1
					elsif user_input == 'straight'
						return :kitchen
					elsif user_input == 'turn around'
						return :livingroom
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :dead_end

					@previous_room = :hallway_2

					if user_input == 'right'
						return :kitchen
					elsif user_input == 'left'
						return :livingroom
					elsif user_input == 'straight'
						return :hallway_1
					elsif user_input == 'turn around'
						return :dead_end
					else
						puts "Was not able to proceed to the next room."
					end
				end
			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def livingroom()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in living room"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'

				@previous_room = :livingroom

				return :hallway_2
			elsif user_input == 'explore'
				return :death #eaten by cat
			else
				puts "Unsure what to do, you stare blankly into the livingroom."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def dead_end()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in DeadEnd"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'right' || user_input != 'left' || user_input != 'straight' || user_input != 'turn around'

			if user_input == 'right' || user_input == 'left' || user_input == 'straight' || user_input == 'turn around'

				@previous_room = :dead_end

				if user_input == 'right'
					puts @wall
				elsif user_input == 'left'
					puts @wall
				elsif user_input == 'straight'
					return :door
				elsif user_input == 'turn around'
					return :hallway_2
				else
					puts "Was not able to proceed to the next room."
				end

			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def door()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Door"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'

				@previous_room = :dead_end

				return :hallway_2
			elsif user_input != 'turn around'
				return :death #door smoosh
			else
				puts "Unsure what to do, you stare blankly at the door."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def stairs()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Stairs"
		puts "Do you go up the stairs?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'yes' || user_input != 'no'

			if user_input == 'yes'

				@previous_room = :stairs

				return :top_stairs
			elsif user_input == 'no'
				return :hallway_1
			else
				puts "Unsure what to do, you stare blankly up at the stairs."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end		
	end

	def top_stairs()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in TopStairs"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'right' || user_input != 'left' || user_input != 'straight' || user_input != 'turn around'

			if user_input == 'right' || user_input == 'left' || user_input == 'straight' || user_input == 'turn around'

				if @previous_room == :stairs

					@previous_room = :top_stairs

					if user_input == 'right'
						return :hallway_3
					elsif user_input == 'left'
						puts @wall
						@previous_room = stairs
					elsif user_input == 'straight'
						return :girls_bedroom
					elsif user_input == 'turn around'
						return :stairs
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :girls_bedroom

					@previous_room = :top_stairs

					if user_input == 'right'
						puts @wall
						@previous_room = :girls_bedroom
					elsif user_input == 'left'
						return :hallway_3
					elsif user_input == 'straight'
						return :stairs
					elsif user_input == 'turn around'
						return :girls_bedroom
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :hallway_3

					@previous_room = :top_stairs

					if user_input == 'right'
						return :girls_bedroom
					elsif user_input == 'left'
						return :stairs
					elsif user_input == 'straight'
						puts @wall
						@previous_room = :hallway_3
					elsif user_input == 'turn around'
						return :hallway_3
					else
						puts "Was not able to proceed to the next room."
					end
				end
			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def hallway_3()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Hallway3"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'right' || user_input != 'left' || user_input != 'straight' || user_input != 'turn around'

			if user_input == 'right' || user_input == 'left' || user_input == 'straight' || user_input == 'turn around'

				if @previous_room == :stairs

					@previous_room = :hallway_3

					if user_input == 'right'
						@previous_room = :stairs
						return :banister
					elsif user_input == 'left'
						return :bathroom
					elsif user_input == 'straight'
						return :master_bedroom
					elsif user_input == 'turn around'
						return :stairs
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :bathroom

					@previous_room = :hallway_3

					if user_input == 'right'
						return :top_stairs
					elsif user_input == 'left'
						return :master_bedroom
					elsif user_input == 'straight'
						@previous_room = :bathroom
						return :banister
					elsif user_input == 'turn around'
						return :bathroom
					else
						puts "Was not able to proceed to the next room."
					end

				elsif @previous_room == :master_bedroom

					@previous_room = :hallway_3

					if user_input == 'right'
						return :bathroom
					elsif user_input == 'left'
						@previous_room = :master_bedroom
						return :banister
					elsif user_input == 'straight'
						return :hallway_3
					elsif user_input == 'turn around'
						return :master_bedroom
					else
						puts "Was not able to proceed to the next room."
					end
				end
			else
				puts @misdirection
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def girls_bedroom()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in GirlBedroom"
	end

	def banister()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Banister"
		puts "Careful!"
		puts "You teeter over the edge!"

		chances_of_falling = rand(5)

		if chances_of_falling == 0
			puts "You've fallen over the edge!"
			return :death
		else
			puts "Phew! Close call!"
			puts "You scurry away from the banister."
			return hallway_3
		end
	end

	def bathroom()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Bathroom"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'

				@previous_room = :bathroom

				return :hallway_3
			elsif user_input == 'explore'
				return :death #drown in toilet
			else
				puts "Unsure what to do, you stare blankly into the bathroom."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def master_bedroom()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in MasterBedroom"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'

				@previous_room = :master_bedroom

				return :hallway_3
			elsif user_input == 'explore'
				return :death #Discovered! Impaled by stiletto
			else
				puts "Unsure what to do, you stare blankly into the master bedroom."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def kitchen()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in Kitchen"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'

				@previous_room = :kitchen

				return :hallway_2
			elsif user_input == 'explore'
				return :inner_kitchen
			else
				puts "Unsure what to do, you stare blankly into the kitchen."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def inner_kitchen()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You are in InnerKitchen"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'
				return :hallway_2
			elsif user_input == 'explore'
				return :final
			else
				puts "Unsure what to do, you stare blankly into the kitchen."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

	def final()
		puts "Previous room: #{@previous_room}"
		puts
		puts "You encounter floor and counter"
		puts "What will you do?"
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'turn around'

			if user_input == 'turn around'
				return :kitchen
			elsif user_input.include?('climb')
				puts "You found the cheese! You won!"
				puts "You will not starve!"
				exit(0)
			elsif user_input == 'explore'
				return :death # mouse trap
			else
				puts "Unsure what to do, you stare blankly into the kitchen."
			end

			prompt
			user_input = $stdin.gets.chomp.downcase
		end
	end

end


a_game = Game.new(:inside_mouse_hole)
a_game.play()