extends Node2D
@onready var dialogBox : DialogBox = $Dialog
@onready var InterestingNode = $InterestingNode

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null

func _ready():
	InterestingNode.get_node("InterestingAnim").play("ExclamDance");

func _on_area_2d_body_entered(body):
	if (PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.BUCKET_KNOCKED):
		dialogBox.SetDialogText("A fox! A great omen, I must throw some of the fish I catch back in the pond so that the pond grows even bigger fish!")
	elif (PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.FISHERMAN_KNOCKED):
		dialogBox.SetDialogText("A fox! A great omen, I must give myself to the waters so fish stocks remain healthy!")
	else:
		dialogBox.SetDialogText("A fox! A dark omen, harbinger of the [color=red]CURSE OF THE POND[/color]")
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
			PlayerStateManager.FishermanIIFate = PlayerStateManager.FishermanIIFates.SOMETHING
			if (PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.BUCKET_KNOCKED):
				var tween = get_tree().create_tween()
				tween.tween_property($Sprite2D, "position", Vector2.LEFT * 4000, 20).as_relative().from_current()
				tween.tween_callback(queue_free)
			elif (PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.FISHERMAN_KNOCKED):
				var tween = get_tree().create_tween()
				tween.tween_property($Sprite2D, "position", Vector2.UP * 75 + Vector2.RIGHT * 100, 0.5).as_relative().from_current()
				tween.tween_property($Sprite2D, "position", Vector2.DOWN * 4000 + Vector2.RIGHT * 1000, 20).as_relative()
				tween.tween_callback(queue_free)
			else:
				#Well, he was either ignored or we asked for a fish and now there's 3 billion frogs and no fish so
				var tween = get_tree().create_tween()
				tween.tween_property($Sprite2D, "modulate", Color.RED, 0.5)
				tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.5)
				tween.tween_property($Sprite2D, "modulate", Color.RED, 0.5)
				tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.5)
				tween.tween_property($Sprite2D, "modulate", Color.RED, 0.5)
				tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.5)
				
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
