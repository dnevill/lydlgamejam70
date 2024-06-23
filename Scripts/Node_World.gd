extends Node2D

@onready var OtherSceneNode = $OtherScenes;

const TILE_SIZE = 32;

const OPENING_LENGTH = 45; # where, in tiles, should the first sublevel be inserted
const SUBLEVEL_LENGTH = 73; # tile count in a subscene, there are more clever ways to do this
#a more polished version of this would ask each sublevel for the right coordinates to put the next sublevel
#also probably specify the y offset of the 'ground' in each since it could vary in theory
#not worth doing all this for a jammy jam though

var rootX = self.position.x;
const W1_1 = preload("res://Scenes/Scene1-1pond.tscn")
const W1_2 = preload("res://Scenes/Scene1-2forest.tscn")

const W2_1 = preload("res://Scenes/Scene2-1pond.tscn")
const W2_2forest = preload("res://Scenes/Scene2-2forest.tscn")
const W2_2field = preload("res://Scenes/Scene2-2field.tscn")

const W3_1fish = preload("res://Scenes/Scene3-1fish.tscn")
const W3_1frog = preload("res://Scenes/Scene3-1frog.tscn")

const W3_2farm = preload("res://Scenes/Scene3-2farm.tscn")
const W3_2field = preload("res://Scenes/Scene3-2field.tscn")
const W3_2forest = preload("res://Scenes/Scene3-2forest.tscn")

const WCAVE = preload("res://Scenes/Cave.tscn");


var bg_forest = preload("res://Assets/Backgrounds/forest_background_1.png")
var fg_forest = preload("res://Assets/Backgrounds/forest_background_2.png")
var bg_no_forest = preload("res://Assets/Backgrounds/no_forest_background_1.png")
var fg_no_forest = preload("res://Assets/Backgrounds/no_forest_background_2.png")

@onready var fader = $FadeOutIn

func _on_World_ready():
	if PlayerStateManager.LumberjackAxeFate == PlayerStateManager.LumberjackAxeFates.GAVE:
		print("LumberjackAxeFate: " + PlayerStateManager.LumberjackAxeFates.find_key(PlayerStateManager.LumberjackAxeFate) + " so we are swapping to the other parallax layers")
		$ParallaxBackground/ParallaxLayer/Sprite2D.texture = bg_no_forest
		$ParallaxBackground/ParallaxLayer2/Sprite2D.texture = fg_no_forest
	else:
		print("LumberjackAxeFate: " + PlayerStateManager.LumberjackAxeFates.find_key(PlayerStateManager.LumberjackAxeFate) + " so we are using the OG parallax layers")
		$ParallaxBackground/ParallaxLayer/Sprite2D.texture = bg_forest
		$ParallaxBackground/ParallaxLayer2/Sprite2D.texture = fg_forest

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
				newScene1 = W3_1frog
			
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
	newSceneInst2.position.x = newSceneInst1.position.x + (TILE_SIZE * SUBLEVEL_LENGTH);
	
	# insert cave
	var newCaveInst = WCAVE.instantiate();
	OtherSceneNode.add_child(newCaveInst);
	newCaveInst.position.x = newSceneInst2.position.x + (TILE_SIZE * SUBLEVEL_LENGTH);
	$PlayerRigidBody.freeze = true
	fader.visible = true
	fader.FadeIn()


func _on_fade_out_in_done_fading_in():
	$PlayerRigidBody.freeze = false
	fader.visible = false
