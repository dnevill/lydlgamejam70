extends Node2D

@onready var NudgeNode = $NudgeNode;

func _ready():
	NudgeNode.visible = false;
	pass

func _process(_delta):
	pass

func _on_warning_area_body_entered(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.get_node("NudgeAnim").play("NudgeIconBounce");
		NudgeNode.visible = true;
		pass
	pass

func _on_warning_area_body_exited(body):
	if body.name == "PlayerRigidBody":
		NudgeNode.visible = false;
		NudgeNode.get_node("NudgeAnim").stop();
		pass
	pass
