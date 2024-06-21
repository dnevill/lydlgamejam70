extends Node2D
@onready var dialogBox : DialogBox = $Dialog

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

@onready var tween = Tween
#$enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogBox.SetDialogText("Bro, I am like SO strongk. Like SO. STRONK. Let me go and I will LITERALLY jump over the moon. You'll see")
	dialogBox.SetOption1Text("Free the ox")
	dialogBox.SetOption2Text("Leave it yoked")
	#dialogBox.SetOption3Text("Ignore them")
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

	pass # Replace with function body.



func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			print("ox set free")
			PlayerStateManager.OxFate = PlayerStateManager.OxFates.RELEASED
			$"Flight noise".pitch_scale = 0.8
			$"Flight noise".play()
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D, "scale", Vector2(4,4), 2)
			tween.parallel().tween_property($Sprite2D, "position", Vector2.RIGHT * 500, 0.5).as_relative().from_current()
			tween.tween_property($Sprite2D, "position", Vector2.LEFT * 1000 + Vector2.UP * 100, 1.5).as_relative()
			ready_to_interact = false
		2:
			print("Ignored, set a timer to allow interaction again in a few seconds")
			#Note that since it stays active, this fate might get set, then later adjusted back while they're still visible on camera
			#So don't later on hook up an event listener to this fate to affect things with its on_changed or anything
			PlayerStateManager.OxFate = PlayerStateManager.OxFates.PLOWED
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
