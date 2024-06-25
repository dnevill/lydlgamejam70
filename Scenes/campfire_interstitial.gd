extends Control

var main_menu = preload("res://Scenes/main_menu.tscn")
@onready var fade_out_in = $FadeOutIn

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStateManager.cycleNum > 3:
		PlayerStateManager.cycleNum = 3
		$campfire3.visible = true
		$campfire2.visible = false
		$Label.visible = false
	else:
		$campfire3.visible = false
		$campfire2.visible = true
		$Label.visible = true
	$Timer.start()
	fade_out_in.FadeIn()

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		$Timer.stop()
		_on_timer_timeout()

func _on_timer_timeout():
	$FadeOutIn.FadeOut()

func _on_fade_out_in_done_fading_out():
	if is_inside_tree(): get_tree().change_scene_to_packed(main_menu) # Replace with function body.
