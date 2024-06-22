extends Node2D

@onready var NudgeNode = $NudgeNode;

const DOOR_RESTFRAMES = 90;

var PlayerInDoor = false;
var InDoorResting = DOOR_RESTFRAMES;

func _ready():
	NudgeNode.visible = false;
	pass

func _process(_delta):
	if(PlayerInDoor):
		if(InDoorResting > 0):
			if(InDoorResting == DOOR_RESTFRAMES):
				NudgeNode.visible = false;
			InDoorResting -= 1;
			if(InDoorResting == 0):
				print("EXIT CYCLE HERE");

func _on_warning_area_body_entered(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.get_node("NudgeAnim").play("NudgeIconBounce");
		NudgeNode.visible = true;
		pass;
	pass;

func _on_warning_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.visible = false;
		NudgeNode.get_node("NudgeAnim").stop();
		pass;
	pass;


func _on_doorway_area_body_entered(body):
	if body.name == "PlayerRigidBody":
		PlayerInDoor = true;
		InDoorResting = DOOR_RESTFRAMES;
	pass;


func _on_doorway_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		PlayerInDoor = false;
		InDoorResting = DOOR_RESTFRAMES;
		NudgeNode.visible = true;
	pass;
