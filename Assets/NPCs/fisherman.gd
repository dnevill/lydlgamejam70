extends Node2D
@onready var dialogBox : DialogBox = $Dialog

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

#$enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogBox.SetPhoto($Sprite2D.texture)
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	dialogBox.SetDialogText("UwU I'm just a fishin' pal fishin' away at thes fishes :3")
	dialogBox.SetOption1Text("Ask for a fish")
	dialogBox.SetOption2Text("Knock over the bucket of fish")
	dialogBox.SetOption3Text("Knock over the fisherman")
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




func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			print("Asked for a feesh")
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.ASKED_FOR_FISH
			ready_to_interact = false
		2:
			print("Knocked bucket")
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.BUCKET_KNOCKED
			#tweens to send the bucket into the water
			ready_to_interact = false
		3:
			print("Knocked fisherman")
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.FISHERMAN_KNOCKED
			#tweens to send them into the water, with a tween.tween_callback(queue_free)
			ready_to_interact = false
	dialogBox.visible = false
	


func ShakeSprite():
	pass

func _on_timer_timeout():
	if ready_to_interact:
		$IdleSound.play()
		$AnimationPlayer.play("shake quarter sec")


func _on_idle_sound_finished():
	$IdleSound/Timer.start()
