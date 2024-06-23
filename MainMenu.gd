extends Control

var gameScene = preload("res://Node_World.tscn")
var optionsScene = preload("res://Scenes/settings.tscn")
var creditsScene = preload("res://Scenes/Credits.tscn")

@onready var fader = $FadeOutIn

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
	fader.FadeIn()
	$Start.grab_focus()

func _process(_delta):
	$ParallaxBackground.scroll_offset += Vector2(1,0)

func _on_reset_pressed():
	fader.FadeOut()
	PlayerStateManager.resetfates()
	await fader.done_fading_out
	get_tree().reload_current_scene()
	fader.FadeIn()

func _on_credits_pressed():
	fader.FadeOut()
	await fader.done_fading_out
	PlayerStateManager.creditsPBGoffset = $ParallaxBackground.scroll_offset.x;
	get_tree().change_scene_to_packed(creditsScene)

func _on_options_pressed():
	fader.FadeOut()
	await fader.done_fading_out	
	get_tree().change_scene_to_packed(optionsScene)

func _on_start_pressed():
	fader.FadeOut()
	await fader.done_fading_out	
	get_tree().change_scene_to_packed(gameScene)

func _on_fade_out_in_done_fading_out():
	pass;
