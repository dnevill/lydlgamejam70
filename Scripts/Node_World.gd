extends Node2D

@onready var OtherSceneNode = $OtherScenes;

const TILE_SIZE = 32;

func _on_World_ready():
	#
	# Includes Scene 1-2 after 30 tiles of main level.
	#
	var newScene = load("res://Scenes/Scene1-2.tscn");
	var newSceneInst = newScene.instantiate();
	OtherSceneNode.add_child(newSceneInst);
	newSceneInst.position.x = TILE_SIZE * 30;
	#
	pass;
