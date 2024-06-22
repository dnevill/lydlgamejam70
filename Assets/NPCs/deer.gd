extends Node2D
@onready var dialogBox : DialogBox = $Dialog

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

var myFate = PlayerStateManager.DeerFate
var myFates = PlayerStateManager.DeerFates

#$enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogBox.SetDialogText("I'm so scared, I think one of the humans is looking for me. Which way are they coming from?")
	dialogBox.SetOption1Text("Help the deer")
	dialogBox.SetOption2Text("Scare the deer")
	dialogBox.SetOption3Text("Ignore them")
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
			print("Oh no the deer is helped")
			PlayerStateManager.DeerFate = PlayerStateManager.DeerFates.HELPED
			$DialogSound.pitch_scale = 0.8
			$DialogSound.play()
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D, "scale", Vector2(-1,1), 0.5)
			tween.tween_property($Sprite2D, "position", Vector2.RIGHT * 500, 4).as_relative().from_current()
			ready_to_interact = false
		2:
			print("Oh the player scared the deer")
			PlayerStateManager.DeerFate = PlayerStateManager.DeerFates.SCARED
			$DialogSound.pitch_scale = 2.5
			$DialogSound.play()
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D, "position", Vector2.LEFT * 2000, 8).as_relative().from_current()
			ready_to_interact = false
		3:
			print("Ignored, set a timer to allow interaction again in a few seconds")
			#Note that since it stays active, this fate might get set, then later adjusted back while they're still visible on camera
			#So don't later on hook up an event listener to this fate to affect things with its on_changed or anything
			PlayerStateManager.DeerFate = PlayerStateManager.DeerFates.IGNORED
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
