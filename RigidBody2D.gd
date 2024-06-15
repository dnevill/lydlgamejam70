extends RigidBody2D

const HORZACCEL = 10000
const MAXSPEED = 500 #This is just the max the player can accelerate to using their own inputs, not a physics limit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		self.scale = Vector2(-1,1)
		if self.linear_velocity.x > -MAXSPEED:
			self.apply_central_impulse(Vector2(-HORZACCEL*delta,0))
	elif Input.is_action_pressed("ui_right"):
		self.scale = Vector2(1,1)
		if self.linear_velocity.x < MAXSPEED:
			self.apply_central_impulse(Vector2(HORZACCEL*delta,0))
	pass
