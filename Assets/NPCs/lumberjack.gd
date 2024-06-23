extends Node2D
@onready var dialogBox : DialogBox = $Dialog
@onready var InterestingNode = $InterestingNode

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

@onready var tween = Tween
#$enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
# Called when the node enters the scene tree for the first time.
func _ready():
	InterestingNode.get_node("InterestingAnim").play("ExclamDance");
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	dialogBox.SetDialogText("A lumberjack stands in the forest, their axe stuck in a tree. You might be able to help them get it back.")
	dialogBox.SetOption1Text("Help them get the axe")
	dialogBox.SetOption2Text("Steal the axe")
	dialogBox.SetOption3Text("Leave the axe in the tree")
	dialogBox.SetPhoto($Sprite2D.texture)
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
		InterestingNode.visible = true;

func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			#print("We gave him the axe")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
			PlayerStateManager.LumberjackAxeFate = PlayerStateManager.LumberjackAxeFates.GAVE
			ready_to_interact = false
		2:
			#print("We stealin' that axe weee")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
			PlayerStateManager.LumberjackAxeFate = PlayerStateManager.LumberjackAxeFates.STOLE
			ready_to_interact = false
		3:
			#print("We left the axe in the tree")
			PlayerStateManager.LumberjackAxeFate = PlayerStateManager.LumberjackAxeFates.LEFT
			InterestingNode.visible = false;
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
