class Game

	def initialize(room_map)

		@quips = [
			"Hopefully you get reincarnated as rock, you might do better.",
			"You had one job!",
			"I guess it's THAT kind of day.",
			"Death is very becoming of you!"
		]

		@death_scene = {
			:starvation => "You have give up on the search for food and starve!",
			:smooshed => "The door suddenly opens and smooshes you against the wall!",
			:cat => "A cat in the livingroom hunts you down and eats you!",
			:suicide => "You fall over the edge and accidentally commit suicide!",
			:toilet => "Mesmerized by the shiny giant bowl, you climb it to check it out.\nYou slip and fall into the toilet and drown!",
			:hamster => "Death by hamster",
			:stiletto => "You are discovered by the lady of the house!\nShe impales you with her stiletto!",
			:trap => "You sniff around on the ground and catch the whiff of a bit\nof cheese. Following the scent, you find the tiny morsel\nsitting on some weird contraption.\n**SMACK**\nYou unwittingly stumble onto a mouse trap and it has crushed\nyour skull!",
		}

		@misdirection = "Not knowing a direction to go in, you run around in a circle."

		@wall = "Ouch! You walked into a wall!"

		@room_map = room_map
		@previous_room = @room_map

		puts <<START
Starting... Mouse Game

Welcome to Mouse Game, the game where you play as a hungry 
mouse in search of food. In order to find food, navigate and 
explore the house. To win the game, you must find the cheese. 
Careful! Dangers may await you...

INSTRUCTIONS
To move, enter the actions 'right', 'left', 'straight', or 
'turn around'. You can also investigate some rooms by entering 
'explore'.

Good luck on your search for food!

Hit enter to start your journey :)
START

		start = $stdin.gets.chomp
	end

	def play()
		@next_room = @room_map

		while true
			puts "\n--------------------\n\n"
			room = method(@next_room)
			@next_room = room.call()
		end
	end

	def prompt
		print "> "
	end

	def death()

		if @next_room == :inside_mouse_hole || @next_room == :mouse_hole
			puts @death_scene[:starvation]
		elsif @next_room == :door
			puts @death_scene[:smooshed]
		elsif @next_room == :livingroom
			puts @death_scene[:cat]
		elsif @next_room == :banister
			puts @death_scene[:suicide]
		elsif @next_room == :bathroom
			puts @death_scene[:toilet]
		elsif @next_room == :girls_bedroom
			puts @death_scene[:hamster]
		elsif @next_room == :master_bedroom
			puts @death_scene[:stiletto]
		elsif @next_room == :inner_kitchen
			puts @death_scene[:trap]
		else
			puts "Failed to enter death scene."
		end
			
		puts "You have died..."
		puts @quips[rand(0..(@quips.length - 1))] + "\n"
		exit(1)
	end

	def inside_mouse_hole()

		puts <<INTRO
In the middle of winter, there is a very little food for 
most animals to eat. You are a hungry mouse, desperately 
searching looking for food in a small field.Your vision is 
poor, but you see something bright a short distance away. It's 
a house! It doesn't look too very far away, so you decide to 
make your way to it. The journey is short, and you manage to 
squeeze through a big crack in the side of the house.

The crack only lets you into the walls of the house, but it is 
still nice and warm. Satisfied with yourself, you continue your 
search for food. There seems to some light filtering in 
somewhere. You follow the light until you reach a hole.It is a 
hole to the inside of the house! You might be able to find some 
food if you explore the inside. However, this is much riskier 
than you would like...

Do you go through the hole?
INTRO
		prompt

		user_input = $stdin.gets.chomp.downcase

		while user_input != 'yes' || user_input != 'no'

			if user_input == 'yes'
				return :mouse_hole
			elsif user_input == 'no'
				return :death
			else
				puts "Think a little harder, you are starving and are not thinking\nstraight."
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