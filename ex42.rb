class Movement
	def right
		return yield
	end

	def left
		return yield
	end

	def straight
		return yield
	end

	def turn_around
		return yield
	end

	def go(room1, room2, room3, room4)
		right(room1)
		left(room2)
		straight(room3)
		turn_around(room4)
	end
end

class Room < Movement
	def enter
		puts "This scene is not yet configured. Subclass it and implement enter."
		exit(1)
	end
end

class Engine

	def initialize(room_map)
		@room_map = room_map
	end

	def play
		current_room = @room_map.opening_room()
		last_room = @room_map.next_room('finished')

		while current_room != last_room
			next_room_name = current_room.enter
			current_room = @room_map.next_room(next_room_name)
		end

		current_room.enter
	end

end

class Death

	@@quips = [
		"Hopefully you get reincarnated as rock, you might do better.",
		"You had one job!",
		"I guess it's THAT kind of day.",
		"Death is becoming of you!"
	]

	def enter(reason)
		puts reason
		puts "You have died..."
		puts @@quips[rand(0..(@@quips.length - 1))]
		exit(1)
	end
end

class InsideMouseHole < Room

	def enter

		return 'mouse_hole'
	end
end

class MouseHole < Room

	def enter
		if last_room = 'inside_mouse_hole' || last_room = 'mouse_hole'
			go('wall', 'wall', 'hallway1', Death.new("You give up on the search for food, and starve!"))
		elsif last_room = 'hallway1'
			go('wall', 'wall', Death.new("You give up on the search for food, and starve!"), 'hallway1')
		else
			puts :circle
		end

		return 'mouse_hole'
	end
end

class Hallway1 < Room

	def enter
		if last_room = 'mouse_hole'
			go('hallway2', 'stairs', 'wall', 'mouse_hole')
		elsif last_room = 'stairs'
			go('mouse_hole', 'wall', 'hallway2', 'stairs')
		elsif last_room = 'hallway2'
			go('wall', 'mouse_hole', 'hallway1', 'stairs')
		else
			puts :circle
		end

		return 'mouse_hole'
	end
end

class Hallway2 < Room
	
	def enter
		if last_room = 'hallway1'
			go('livingroom', 'kitchen', 'dead_end', 'hallway1')
		elsif last_room = 'livingroom'
			go('dead_end', 'hallway1', 'kitchen', 'livingroom')
		elsif last_room = 'dead_end'
			go('kitchen', 'livingroom', 'hallway1', 'dead_end')
		else
			puts :circle
		end

		return 'hallway1'
	end
end

class Livingroom < Room
	def enter
	end
end

class DeadEnd < Room
	def enter
	end
end

class Door < Room
end

class Kitchen < Room
	def enter
	end
end

class Stairs < Room
	def enter
	end
end

class TopStairs < Room
	def enter
	end
end

class Hallway3 < Room
	def
	end
end

class GirlBedroom < Room
	def enter
	end
end

class Banister < Room
end

class Bathroom < Room
	def enter
	end
end

class MasterBedroom < Room
	def enter
	end
end

class Kitchen < Room
	def enter
	end
end

class InnerKitchen < Room
	def enter
	end
end

class Finished < Room

	def enter
		puts "You found the cheese! You won!"
		puts "You will not starve!"
	end
end

class Map
	@@rooms = {
		:wall => "You've walked into a wall.",
		:circle => "You run in a circle, and get disoriented.",
		'inside_mouse_hole' => InsideMouseHole.new,
		'mouse_hole' => MouseHole.new,
		'hallway1' => Hallway1.new,
		'hallway2' => Hallway2.new,		
		'livingroom' => Livingroom.new,
		'dead_end' => DeadEnd.new,
		'door' => Door.new,
		'stairs' => Stairs.new,
		'top_stairs' => TopStairs.new,
		'hallway3' => Hallway3.new,		
		'girl_bedroom' => GirlBedroom.new,
		'banister' => Banister.new,
		'bathroom' => Bathroom.new,
		'master_bedroom' => MasterBedroom.new,
		'kitchen' => Kitchen.new,
		'inner_kitchen' InnerKitchen.new,
		'death' => Death.new,
		'finished' => Finished.new
	}
	def initialize(start_room)
		@start_room = start_room
	end

	def next_room(room_name)
		val = @@rooms[room_name]
		return val
	end

	def opening_room()
		return next_room(@start_room)
	end
end


a_map = Map.new('inside_mouse_hole')
a_game = Engine(a_map)
a_game.play

