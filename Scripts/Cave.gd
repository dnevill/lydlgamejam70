extends Node2D

@onready var NudgeNode = $NudgeNode;
@onready var fader = $FadeOutIn;

var PlayerInDoor = false;

func _ready():
	fader.FadeIn()
	NudgeNode.visible = false;
	pass

func _process(_delta):
	if(PlayerInDoor):
		fader.FadeOut()
		PlayerStateManager.EndCycle()

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
		var pbody : Player = body;
		pbody.freeze = true;
		PlayerInDoor = true;

#hopefully this doesn't happen but good to handle it just in case
func _on_doorway_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		PlayerInDoor = false;
		NudgeNode.visible = true;
