extends Control

var gameScene = preload("res://Node_World.tscn")
var optionsScene = preload("res://delvansandboxNode_World.tscn")
var creditsScene = preload("res://delvansandboxNode_World.tscn")

func _ready():
	if PlayerStateManager.LumberjackAxeFate == PlayerStateManager.LumberjackAxeFates.GAVE:
		$ParallaxBackground/ParallaxLayer.visible = false
		$ParallaxBackground/ParallaxLayer2.visible = false
		$ParallaxBackground/ParallaxLayer3.visible = true
		$ParallaxBackground/ParallaxLayer4.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ParallaxBackground.scroll_offset += Vector2(1,0)

func _on_reset_pressed():
	PlayerStateManager.resetfates()

func _on_credits_pressed():
	get_tree().change_scene_to_packed(creditsScene) # Replace with function body.


func _on_options_pressed():
	get_tree().change_scene_to_packed(optionsScene)


func _on_start_pressed():
	get_tree().change_scene_to_packed(gameScene)
