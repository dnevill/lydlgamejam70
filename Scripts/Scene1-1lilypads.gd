extends TileMap
const TILE_SIZE = 32;
const COOLDOWN = 3;

var originalY = self.position.y;
var setpointY = originalY;
var timetomove = COOLDOWN;

func _ready():
	pass;

func _process(delta):
	#
	#	Lilypads erratically move up and down.
	#
	if timetomove > 0:
		timetomove -= 1;
	else:
		timetomove = COOLDOWN;
		if self.position.y == setpointY:
			var rng = randi_range(1,5);
			match rng:
				1:
					setpointY = originalY - TILE_SIZE;
				2:
					setpointY = originalY + TILE_SIZE;
				3:
					setpointY = originalY;
		elif self.position.y > setpointY:
			if abs(self.position.y - setpointY) > TILE_SIZE:
				self.position.y -= 10;
			elif abs(self.position.y - setpointY) > TILE_SIZE/2:
				self.position.y -= 4;
			if abs(self.position.y - setpointY) > TILE_SIZE/4:
				self.position.y -= 2;
			else:
				self.position.y -= 1;
		else:
			if abs(self.position.y - setpointY) > TILE_SIZE:
				self.position.y += 10;
			elif abs(self.position.y - setpointY) > TILE_SIZE/2:
				self.position.y += 4;
			if abs(self.position.y - setpointY) > TILE_SIZE/4:
				self.position.y += 2;
			else:
				self.position.y += 1;
