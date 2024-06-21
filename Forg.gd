extends RigidBody2D

@onready var animSprt = $AnimatedSprite2D
const JUMP_POWER = 30

var forgtype = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	forgtype = randi_range(0,3)
	match forgtype:
		0:
			animSprt.play("blue")
		1:
			animSprt.play("red")
		2:
			animSprt.play("green")
		3:
			animSprt.play("smol")


func _on_timer_timeout():
	$Timer.wait_time = 4 + randf_range(-1, 1)
	apply_central_impulse(Vector2.UP * JUMP_POWER)
	match forgtype:
		0:
			$Frog1SFX.play()
		1:
			$Frog1SFX.pitch_scale = 0.8
			$Frog1SFX.play()
		2:
			$Frog2SFX.play()
		3:
			$Frog1SFX.pitch_scale = 2
			$Frog1SFX.play()
	pass # Replace with function body.
