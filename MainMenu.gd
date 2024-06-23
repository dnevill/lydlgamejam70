extends Control

var gameScene = preload("res://Node_World.tscn")
var optionsScene = preload("res://delvansandboxNode_World.tscn")
var creditsScene = preload("res://Scenes/Credits.tscn")

func _ready():
	$ParallaxBackground.scroll_offset = Vector2(PlayerStateManager.creditsPBGoffset,0);
	if PlayerStateManager.LumberjackAxeFate == PlayerStateManager.LumberjackAxeFates.GAVE:
		$ParallaxBackground/ParallaxLayer.visible = false
		$ParallaxBackground/ParallaxLayer2.visible = false
		$ParallaxBackground/ParallaxLayer3.visible = true
		$ParallaxBackground/ParallaxLayer4.visible = true
	else:
		$ParallaxBackground/ParallaxLayer.visible = true
		$ParallaxBackground/ParallaxLayer2.visible = true
		$ParallaxBackground/ParallaxLayer3.visible = false
		$ParallaxBackground/ParallaxLayer4.visible = false
	$Start.grab_focus()

func _process(_delta):
	$ParallaxBackground.scroll_offset += Vector2(1,0)

func _on_reset_pressed():
	PlayerStateManager.resetfates()

func _on_credits_pressed():
	PlayerStateManager.creditsPBGoffset = $ParallaxBackground.scroll_offset.x;
	get_tree().change_scene_to_packed(creditsScene)

func _on_options_pressed():
	get_tree().change_scene_to_packed(optionsScene)

func _on_start_pressed():
	get_tree().change_scene_to_packed(gameScene)
