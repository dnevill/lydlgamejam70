extends Node2D

@onready var OtherSceneNode = $OtherScenes;

const TILE_SIZE = 32;

const OPENING_LENGTH = 45; # where, in tiles, should the first sublevel be inserted
const INBETWEEN_LENGTH = 0; # how many tiles are between the first and second sublevel
const SUBLEVEL_LENGTH = 73; # tile count in a subscene, there are more clever ways to do this
#a more polished version of this would ask each sublevel for the right coordinates to put the next sublevel
#also probably specify the y offset of the 'ground' in each since it could vary in theory
#not worth doing all this for a jammy jam though

var rootX = self.position.x;

func _on_World_ready():
	# insert 1st sublevel
	var newScene1 = load("res://Scenes/Scene3-1fish.tscn");
	var newSceneInst1 = newScene1.instantiate();
	OtherSceneNode.add_child(newSceneInst1);
	newSceneInst1.position.x = rootX + (TILE_SIZE * OPENING_LENGTH);
	
	# insert 2nd sublevel
	var newScene2 = load("res://Scenes/Scene3-2forest.tscn");
	var newSceneInst2 = newScene2.instantiate();
	OtherSceneNode.add_child(newSceneInst2);
	newSceneInst2.position.x = newSceneInst1.position.x + (TILE_SIZE * (SUBLEVEL_LENGTH + INBETWEEN_LENGTH));
	
	# insert cave
	var newCave = load("res://Scenes/Cave.tscn");
	var newCaveInst = newCave.instantiate();
	OtherSceneNode.add_child(newCaveInst);
	newCaveInst.position.x = newSceneInst2.position.x + (TILE_SIZE * SUBLEVEL_LENGTH);
	
	pass;
