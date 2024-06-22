extends Node2D
@onready var dialogBox : DialogBox = $Dialog


const LAUNCH_VECTOR = Vector2(1200,-1000)
var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer : Player = null
var ready_to_launch_again = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	dialogBox.SetDialogText("You come across a goose by the forest pond. It might be able to help you cross the pond, but your tummy begins to rumble.")
	dialogBox.SetOption1Text("Eat the goose")
	dialogBox.SetOption2Text("Ask the goose to carry you")
	dialogBox.SetOption3Text("Ignore the goose")
	dialogBox.SetPhoto($Sprite2D.texture)
	if body.name == "PlayerRigidBody" and ready_to_launch_again:
		body.apply_central_impulse(LAUNCH_VECTOR)
	elif body.name == "PlayerRigidBody" and ready_to_interact:
		ready_to_interact = false
		print("Hey the player touched me OMGEEEEE lets spawn a dialogbox")
		body.in_dialog = true
		disabledPlayer = body
		dialogBox.Reveal()
		$DialogSound.play()

func _on_area_2d_body_exited(body):
	if body.name == "PlayerRigidBody" and waiting_to_interact:
		print("Hey the player stopped touchin' me")
		waiting_to_interact = false
		ready_to_interact = true

func _on_dialog_option_selected(optionNumber):
	match optionNumber:
		1:
			print("Oh no the goose is dead")
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.ATE
			z_index = 1
			$DialogSound.pitch_scale = 0.5
			$DialogSound.play()
			$CPUParticles2DFeathers.emitting = true
			$CPUParticles2DFeathers2.emitting = true
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D, "scale", Vector2(1,-1), 0.5)
			tween.parallel().tween_property($Sprite2D, "position", Vector2.UP * 50, 0.5).as_relative().from_current()
			tween.tween_property($Sprite2D, "position", Vector2.DOWN * 400, 4).as_relative()
			tween.parallel().tween_property($Sprite2D, "rotation", 30, 4)
			tween.tween_callback(queue_free)
			ready_to_interact = false
			disabledPlayer.in_dialog = false
		2:
			print("Hooray the goose carries the player here")
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.HELPED
			var tween = get_tree().create_tween()
			$ChargeSFX.play()
			tween.tween_property($".", "position", Vector2.LEFT * 128, 1.5).as_relative().from_current()
			tween.parallel().tween_property($".", "scale", scale * Vector2(-1,1), 1.5)
			tween.tween_property($".", "position", Vector2.RIGHT * 128, 0.07).as_relative().set_delay(1.5)
			tween.tween_callback(player_launchtime)
			ready_to_interact = false
		3:
			print("Ignored, set a timer to allow goose interaction again in a few seconds")
			#Note that since it stays active, this fate might get set, then later adjusted back while they're still visible on camera
			#So don't later on hook up an event listener to this fate to affect things with its on_changed or anything
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.IGNORED
			disabledPlayer.in_dialog = false
			ready_to_interact = false
			waiting_to_interact = true
	dialogBox.visible = false
	

func player_launchtime():
	disabledPlayer.in_dialog = false
	disabledPlayer.freeze = false
	disabledPlayer.apply_central_impulse(LAUNCH_VECTOR)
	ready_to_launch_again = true

func ShakeSprite():
	pass

func _on_timer_timeout():
	if ready_to_interact:
		$IdleSound.play()
		$AnimationPlayer.play("shake quarter sec")


func _on_idle_sound_finished():
	$IdleSound/Timer.start()


func _on_charge_sfx_finished():
	pass # Replace with function body.
