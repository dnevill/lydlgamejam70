extends Node2D

@onready var OtherSceneNode = $OtherScenes;

const TILE_SIZE = 32;
const SUBLEVEL_LENGTH = 73 #tile count in a subscene, there are more clever ways to do this
#a more polished version of this would ask each sublevel for the right coordinates to put the next sublevel
#also probably specify the y offset of the 'ground' in each since it could vary in theory
#not worth doing all this for a jammy jam though

func _on_World_ready():
	#
	# Includes a scene after 30 tiles of main level, and another scene at the sublevel length in tiles beyond that
	#

	var newScene = load("res://Scenes/Scene1-1pond.tscn");
	var newSceneInst = newScene.instantiate();
	OtherSceneNode.add_child(newSceneInst);
	newSceneInst.position.x = TILE_SIZE * 30;
	var newScene2 = load("res://Scenes/Scene1-2forest.tscn");
	var newSceneInst2 = newScene2.instantiate();
	OtherSceneNode.add_child(newSceneInst2);
	newSceneInst2.position.x = TILE_SIZE * SUBLEVEL_LENGTH + newSceneInst.position.x;

