extends Control

@onready var StageNode = $StageNode;
@onready var Parallax = $ParallaxBackground;
var mainMenuSCN = preload("res://Scenes/main_menu.tscn");

func _ready():
	$ParallaxBackground.scroll_offset = Vector2(PlayerStateManager.creditsPBGoffset,0);

func _process(_delta):
	Parallax.scroll_offset += Vector2(8,0);
	StageNode.position.y -= 4;

func _on_back_pressed():
	PlayerStateManager.creditsPBGoffset = $ParallaxBackground.scroll_offset.x;
	get_tree().change_scene_to_packed(mainMenuSCN);
