extends Node2D

@onready var OtherSceneNode = $OtherScenes;

const TILE_SIZE = 32;

func _on_World_ready():
	#
	# Includes a Scene after 30 tiles of main level.
	#
	var newScene = load("res://Scenes/Scene3-2field.tscn");
	var newSceneInst = newScene.instantiate();
	OtherSceneNode.add_child(newSceneInst);
	newSceneInst.position.x = TILE_SIZE * 30;
	#
	pass;
