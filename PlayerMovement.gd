class_name Player extends RigidBody2D

const HORZACCEL = 60000
var vertaccel = 500
const MAXSPEED = 250 #This is just the max the player can accelerate to using their own inputs, not a physics limit

var is_grounded = true;

var in_dialog = false;
var teleport_position = null

var has_lingering_jump = false


var idle_anim = "idle"
var walk_anim = "walk"
var jump_anim = "jump"



@onready var start_position = self.position


func _ready():
	var cycle = PlayerStateManager.cycleNum
	if cycle > 1:
		if PlayerStateManager.GooseFate == PlayerStateManager.GooseFates.HELPED:
			idle_anim = "idle_winged"
			walk_anim = "walk_winged"
			jump_anim = "jump_winged"
			vertaccel = 750
		elif PlayerStateManager.GooseFate == PlayerStateManager.GooseFates.ATE:
			idle_anim = "idle_griffox"
			walk_anim = "walk_griffox"
			jump_anim = "jump_griffox"
			gravity_scale = 0.5
		else:
			idle_anim = "idle"
			walk_anim = "walk"
			jump_anim = "jump"
	
	if cycle == 1:
		$Cycle1Music.play()
	elif cycle == 2:
		$Cycle2Music.play()
	else:
		$Cycle3Music.play()
	
	$PlayerAnimSprite.play(idle_anim)


func GetFeatherParent():
	return $PlayerAnimSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_end"):
		PlayerStateManager.printfates()
	
	if Input.is_action_just_pressed("ui_page_up"):
		PlayerStateManager.incrementfates()
	if Input.is_action_just_pressed("ui_page_down"):
		PlayerStateManager.decrementfates()
	freeze = in_dialog
	if not in_dialog:
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimSprite.flip_h = true;
			for child in $PlayerAnimSprite.get_children():
				child.flip_h = true
			if linear_velocity.x > -MAXSPEED:
				apply_central_force(Vector2(-HORZACCEL*delta,0))
		elif Input.is_action_pressed("ui_right"):
			$PlayerAnimSprite.flip_h = false;
			for child in $PlayerAnimSprite.get_children():
				child.flip_h = false
			scale = Vector2(1,1)
			if linear_velocity.x < MAXSPEED:
				apply_central_force(Vector2(HORZACCEL*delta,0))
		#else:
			#No left/right input, so we should start damping our movement back down
			#var movementVector = player.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			#start some jump animation
			$PlayerAnimSprite.play(jump_anim)
			$JumpSFX.play()
			#print("You jumped! and " + str(is_on_floor()))
			#This is a 'just pressed' so we use an impulse, we don't care about integrating across frames
			apply_central_impulse(Vector2(0,-vertaccel))
			is_grounded = false;
			has_lingering_jump = false
		elif is_on_floor():
			if abs(linear_velocity.x) > 1:
				$PlayerAnimSprite.play(walk_anim)
				$IdleTimer.stop()
				if $WalkNoiseTimer.is_stopped():
					$WalkSFX.play()
					$WalkNoiseTimer.start()
			else:
				if $IdleTimer.is_stopped():
					$IdleTimer.start()
			is_grounded = true;
	var spdscale = min(1,abs(linear_velocity.x) / (1.0 * MAXSPEED))
	$PlayerAnimSprite.speed_scale = spdscale


func is_on_floor():
	if self.test_move(transform, Vector2.DOWN) or has_lingering_jump:
		return true
	else:
		return false



func _on_body_entered(body):
	if body.name == "Killplane":
		teleport_position = start_position
	if body.name == "SpecialTerrain":
		has_lingering_jump = true

	


func _integrate_forces(state):
	if teleport_position != null:
		var mytran = state.get_transform()
		mytran.origin = teleport_position
		teleport_position = null
		state.set_transform(mytran)


func _on_idle_timer_timeout():
	if abs(linear_velocity.x) < 1 and is_grounded:
		$PlayerAnimSprite.play(idle_anim) # Replace with function body.


func _on_player_anim_sprite_ready():
	$PlayerAnimSprite.play(idle_anim)
