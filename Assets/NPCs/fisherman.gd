extends Node2D
@onready var dialogBox : DialogBox = $Dialog
@onready var InterestingNode = $InterestingNode

const FEESH_RIGID_BODY = preload("res://Assets/NPCs/feesh_rigid_body.tscn");

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null;

#$enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
# Called when the node enters the scene tree for the first time.
func _ready():
	InterestingNode.get_node("InterestingAnim").play("ExclamDance");
	dialogBox.SetPhoto($Sprite2D.texture)
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	dialogBox.SetDialogText("A fisherman! The pond must have fish big enough for them to catch now.")
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
		InterestingNode.visible = true;

func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			#print("Asked for a feesh")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.ASKED_FOR_FISH
			ready_to_interact = false
			var feesh = FEESH_RIGID_BODY.instantiate();
			disabledPlayer.GetFeatherParent().add_child(feesh);
		2:
			#print("Knocked bucket")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.BUCKET_KNOCKED
			$Sprite2D/Sprite2DFish.z_index += 3
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D/Sprite2DFish, "position", Vector2.UP * 75 + Vector2.RIGHT * 100, 0.5).as_relative().from_current()
			tween.tween_property($Sprite2D/Sprite2DFish, "position", Vector2.DOWN * 4000 + Vector2.RIGHT * 1000, 20).as_relative()
			tween.tween_callback($Sprite2D/Sprite2DFish.queue_free)
			#tweens to send the bucket into the water
			ready_to_interact = false
		3:
			#print("Knocked fisherman")
			InterestingNode.get_node("InterestingAnim").stop();
			InterestingNode.visible = false;
			PlayerStateManager.FishermanFate = PlayerStateManager.FishermanFates.FISHERMAN_KNOCKED
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D, "position", Vector2.UP * 75 + Vector2.RIGHT * 100, 0.5).as_relative().from_current()
			tween.tween_property($Sprite2D, "position", Vector2.DOWN * 4000 + Vector2.RIGHT * 1000, 20).as_relative()
			tween.tween_callback(queue_free)
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
