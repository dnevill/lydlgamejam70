extends Node2D

@onready var NudgeNode = $NudgeNode;

const DOOR_RESTFRAMES = 90;


@onready var fader = $FadeOutIn

var PlayerInDoor = false;
var InDoorResting = DOOR_RESTFRAMES;

func _ready():
	fader.FadeIn()
	NudgeNode.visible = false;
	pass

func _process(_delta):
	if(PlayerInDoor):
		fader.FadeOut()
		PlayerStateManager.EndCycle()
		#if(InDoorResting > 0):
		#	if(InDoorResting <= DOOR_RESTFRAMES):
		#		NudgeNode.visible = false;
		#	InDoorResting -= 1;
		#if(InDoorResting <= 0):
		#	PlayerStateManager.EndCycle()

func _on_warning_area_body_entered(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.get_node("NudgeAnim").play("NudgeIconBounce");
		NudgeNode.visible = true;


func _on_warning_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.visible = false;
		NudgeNode.get_node("NudgeAnim").stop();



func _on_doorway_area_body_entered(body):
	if body.name == "PlayerRigidBody":
		var pbody : Player = body
		pbody.freeze = true
		PlayerInDoor = true;
		InDoorResting = DOOR_RESTFRAMES;


#hopefully this doesn't happen but good to handle it just in case
func _on_doorway_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		PlayerInDoor = false;
		InDoorResting = DOOR_RESTFRAMES;
		NudgeNode.visible = true;

