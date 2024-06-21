class_name Player extends RigidBody2D

const HORZACCEL = 100
const VERTACCEL = 500
const MAXSPEED = 250 #This is just the max the player can accelerate to using their own inputs, not a physics limit

var is_grounded = true;

var in_dialog = false;
var teleport_position = null

@onready var start_position = self.position

# Called when the node enters the scene tree for the first time.
func _ready():
	self.apply_central_impulse(Vector2(0,VERTACCEL))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_end"):
		PlayerStateManager.printfates()
	if not in_dialog:
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimSprite.flip_h = true;
			if linear_velocity.x > -MAXSPEED:
				apply_central_impulse(Vector2(-HORZACCEL,0))
		elif Input.is_action_pressed("ui_right"):
			$PlayerAnimSprite.flip_h = false;
			scale = Vector2(1,1)
			if linear_velocity.x < MAXSPEED:
				apply_central_impulse(Vector2(HORZACCEL,0))
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			#start some jump animation
			$PlayerAnimSprite.play("jump")
			print("You jumped! and " + str(is_on_floor()))
			apply_central_impulse(Vector2(0,-VERTACCEL))
			is_grounded = false;
		elif is_on_floor():
			$PlayerAnimSprite.play("walk")
			is_grounded = true;



func is_on_floor():
	if self.test_move(transform, Vector2.DOWN):
		return true
	else:
		return false



func _on_body_entered(body):
	print(body)
	print(body.name)
	if body.name == "Killplane":
		print(body)
		teleport_position = start_position


func _integrate_forces(state):
	if teleport_position != null:
		print(teleport_position)
		var mytran = state.get_transform()
		mytran.origin = teleport_position
		teleport_position = null
		state.set_transform(mytran)
