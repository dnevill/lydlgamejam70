extends Node2D
@onready var dialogBox : DialogBox = $Dialog


const LAUNCH_VECTOR = Vector2(1200,-1000)
var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer : Player = null

@onready var tween = Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogBox.SetDialogText("Oh no, a fox! I've heard foxes are dangerous, pwease be nice.")
	dialogBox.SetOption1Text("Eat the goose")
	dialogBox.SetOption2Text("Ask the goose to carry you")
	dialogBox.SetOption3Text("Ignore the goose")
	dialogBox.SetPhoto($Sprite2D.texture)
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "PlayerRigidBody" and ready_to_interact:
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
	elif body.name == "PlayerRigidBody" and PlayerStateManager.GooseFate == PlayerStateManager.GooseFates.HELPED:
		body.apply_central_impulse(LAUNCH_VECTOR)
		




func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			print("Oh no the goose is dead")
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.ATE
			ready_to_interact = false
		2:
			print("Hooray the goose carries the player here")
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.HELPED
			disabledPlayer.apply_central_impulse(LAUNCH_VECTOR)
			ready_to_interact = false
		3:
			print("Ignored, set a timer to allow goose interaction again in a few seconds")
			#Note that since it stays active, this fate might get set, then later adjusted back while they're still visible on camera
			#So don't later on hook up an event listener to this fate to affect things with its on_changed or anything
			PlayerStateManager.GooseFate = PlayerStateManager.GooseFates.IGNORED
			ready_to_interact = false
			waiting_to_interact = true
	dialogBox.visible = false
	


func ShakeSprite():
	pass

func _on_timer_timeout():
	if ready_to_interact:
		$IdleSound.play()
		$AnimationPlayer.play("shake quarter sec")


func _on_idle_sound_finished():
	$IdleSound/Timer.start()
