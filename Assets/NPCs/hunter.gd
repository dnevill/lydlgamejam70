extends Node2D
@onready var dialogBox : DialogBox = $Dialog
@onready var InterestingNode = $InterestingNode

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

func _ready():
	InterestingNode.get_node("InterestingAnim").play("ExclamDance");

func _on_area_2d_body_entered(body):
	if (PlayerStateManager.DeerFate == PlayerStateManager.DeerFates.HELPED):
		dialogBox.SetDialogText("You cross paths with a hunter in the forest. They ponder as they address you 'Deer haven't been seen in this forest for some time. I wonder if they have been warned of the humans in the area.'")
	elif (PlayerStateManager.DeerFate == PlayerStateManager.DeerFates.SCARED):
		dialogBox.SetDialogText("You cross paths with a hunter in the forest. They see you and say 'Deer were so easy to hunt, they are no longer seen in this forest. Maybe I will start hunting foxes instead.'")
	else:
		dialogBox.SetDialogText("You cross paths with a hunter in the forest. They seem to be focused on tracking a deer and ignore you.")
	dialogBox.SetOption1Text("Carry on")
	#dialogBox.SetOption2Text("Knock over the bucket of fish")
	#dialogBox.SetOption3Text("Knock over the fisherman")
	dialogBox.SetPhoto($Sprite2D.texture)
	if body.name == "PlayerRigidBody" and ready_to_interact:
		ready_to_interact = false
		#print("Hey the player touched me OMGEEEEE lets spawn a dialogbox")
		body.in_dialog = true
		disabledPlayer = body
		dialogBox.Reveal()
		$DialogSound.play()

func _on_area_2d_body_exited(body):
	if body.name == "PlayerRigidBody" and waiting_to_interact:
		#print("Hey the player stopped touchin' me")
		waiting_to_interact = false
		ready_to_interact = true
		InterestingNode.visible = true;

func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			#print("*nods*")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
	ready_to_interact = false
	dialogBox.visible = false

func ShakeSprite():
	pass;

func _on_timer_timeout():
	if ready_to_interact:
		$IdleSound.play()
		$AnimationPlayer.play("shake quarter sec")

func _on_idle_sound_finished():
	$IdleSound/Timer.start()
