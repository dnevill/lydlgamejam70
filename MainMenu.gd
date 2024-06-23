extends Control

var gameScene = preload("res://Node_World.tscn")
var optionsScene = preload("res://Scenes/settings.tscn")
var creditsScene = preload("res://Scenes/Credits.tscn")

var Cycle2Start = preload("res://Assets/Sprites/start_tail_nextcycle.png")
var Cycle2Starthover = preload("res://Assets/Sprites/start_tail_border.png")
var Cycle2Startpressed = preload("res://Assets/Sprites/start_tail_next_pressed.png")

var Cycle1Start = preload("res://Assets/UI/start_tail.png")
var Cycle1Starthover = preload("res://Assets/UI/start_tail_hover.png")
var Cycle1Startpressed = preload("res://Assets/UI/start_tail_pressed.png")

@onready var fader = $FadeOutIn

func _ready():
	print(str($AudioStreamPlayer.bus) + " is the music bus on main menu")
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
	if PlayerStateManager.cycleNum > 1:
		$Start.texture_normal = Cycle2Start
		$Start.texture_hover = Cycle2Starthover
		$Start.texture_pressed = Cycle2Startpressed
	else:
		$Start.texture_normal = Cycle1Start
		$Start.texture_hover = Cycle1Starthover
		$Start.texture_pressed = Cycle1Startpressed
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
