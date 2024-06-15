extends RigidBody2D

const HORZACCEL = 100
const VERTACCEL = 100
const MAXSPEED = 500 #This is just the max the player can accelerate to using their own inputs, not a physics limit

var is_grounded = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.apply_central_impulse(Vector2(0,VERTACCEL))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true;
		if linear_velocity.x > -MAXSPEED:
			apply_central_impulse(Vector2(-HORZACCEL,0))
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false;
		scale = Vector2(1,1)
		if linear_velocity.x < MAXSPEED:
			apply_central_impulse(Vector2(HORZACCEL,0))
	if Input.is_action_pressed("ui_up") and is_on_floor():
		#start some jump animation
		print("You jumped! and " + str(is_on_floor()))
		apply_central_impulse(Vector2(0,-VERTACCEL))

func is_on_floor():
	if self.test_move(transform, Vector2.DOWN):
		return true
	else:
		return false

