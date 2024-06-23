extends Control


var mainMenuSCN = preload("res://Scenes/main_menu.tscn");

func _ready():
	pass # Replace with function body.

func go_back():
	get_tree().change_scene_to_packed(mainMenuSCN);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		go_back();

func _on_back_pressed():
	go_back();


func _on_texture_button_pressed():
	go_back();
