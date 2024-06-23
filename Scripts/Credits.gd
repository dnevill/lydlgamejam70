extends Control

@onready var StageAnim = $StageAnim;
@onready var Parallax = $ParallaxBackground;
var mainMenuSCN = preload("res://Scenes/main_menu.tscn");

func _ready():
	$ParallaxBackground.scroll_offset = Vector2(PlayerStateManager.creditsPBGoffset,0);
	$StageAnim.play("CreditsRoll");

func go_back():
	PlayerStateManager.creditsPBGoffset = $ParallaxBackground.scroll_offset.x;
	get_tree().change_scene_to_packed(mainMenuSCN);

func _process(_delta):
	Parallax.scroll_offset += Vector2(-1,0);
	if Input.is_action_just_pressed("ui_accept"):
		go_back();

func _on_back_pressed():
	go_back();
