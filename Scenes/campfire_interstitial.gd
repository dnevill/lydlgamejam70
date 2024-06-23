extends Control

var main_menu = preload("res://Scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()




func _on_timer_timeout():
	get_tree().change_scene_to_packed(main_menu)
