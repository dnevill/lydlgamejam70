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
const W1_1 = preload("res://Scenes/Scene1-1pond.tscn")
const W1_2 = preload("res://Scenes/Scene1-2forest.tscn")

const W2_1 = preload("res://Scenes/Scene2-1pond.tscn")
const W2_2forest = preload("res://Scenes/Scene2-2forest.tscn")
const W2_2field = preload("res://Scenes/Scene2-2forest.tscn")

const W3_1fish = preload("res://Scenes/Scene3-1fish.tscn")
const W3_1frog = preload("res://Scenes/Scene3-1frog.tscn")

const W3_2farm = preload("res://Scenes/Scene3-2farm.tscn")
const W3_2field = preload("res://Scenes/Scene3-2field.tscn")
const W3_2forest = preload("res://Scenes/Scene3-2forest.tscn")


func _on_World_ready():
	var newScene1 = W1_1
	var newScene2 = W1_2
	PlayerStateManager.printfates()
	match PlayerStateManager.cycleNum:
		2:
			newScene1 = W2_1
			if PlayerStateManager.LumberjackAxeFate != PlayerStateManager.LumberjackAxeFates.GAVE:
				newScene2 = W2_2forest
			else:
				newScene2 = W2_2field
		3:
			if PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.FISHERMAN_KNOCKED or PlayerStateManager.FishermanFate == PlayerStateManager.FishermanFates.BUCKET_KNOCKED:
				newScene1 = W3_1fish
			else:
				newScene2 = W3_1frog
			
			if PlayerStateManager.LumberjackAxeFate != PlayerStateManager.LumberjackAxeFates.GAVE:
				newScene2 = W3_2forest
			elif PlayerStateManager.OxFate == PlayerStateManager.OxFates.RELEASED:
				newScene2 = W3_2field
			else:
				newScene2 = W3_2farm
	# insert 1st sublevel

	var newSceneInst1 = newScene1.instantiate();
	OtherSceneNode.add_child(newSceneInst1);
	newSceneInst1.position.x = rootX + (TILE_SIZE * OPENING_LENGTH);
	
	# insert 2nd sublevel

	var newSceneInst2 = newScene2.instantiate();
	OtherSceneNode.add_child(newSceneInst2);
	newSceneInst2.position.x = newSceneInst1.position.x + (TILE_SIZE * (SUBLEVEL_LENGTH + INBETWEEN_LENGTH));
	
	# insert cave
	var newCave = load("res://Scenes/Cave.tscn");
	var newCaveInst = newCave.instantiate();
	OtherSceneNode.add_child(newCaveInst);
	newCaveInst.position.x = newSceneInst2.position.x + (TILE_SIZE * SUBLEVEL_LENGTH);
	
	pass;
