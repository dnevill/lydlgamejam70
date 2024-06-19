extends Node2D
@onready var dialogBox : DialogBox = $Dialog

var ready_to_interact = true;
var waiting_to_interact = false;
var disabledPlayer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogBox.SetDialogText("Oh no, a fox! I've heard foxes are dangerous, pwease be nice.")
	dialogBox.SetOption1Text("Eat the goose")
	dialogBox.SetOption2Text("Ask the goose to carry you")
	dialogBox.SetOption3Text("Ignore the goose")
	dialogBox.SetPhoto($Sprite2D.texture)
	#Probably need some code here to position the dialog box on screen at a good spot.
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "PlayerRigidBody" and ready_to_interact:
		print("Hey the player touched me OMGEEEEE lets spawn a dialogbox")
		body.in_dialog = true
		disabledPlayer = body
		dialogBox.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "PlayerRigidBody" and waiting_to_interact:
		print("Hey the player stopped touchin' me")
		waiting_to_interact = false
		ready_to_interact = true

	pass # Replace with function body.



func _on_dialog_option_selected(optionNumber):
	disabledPlayer.in_dialog = false
	match optionNumber:
		1:
			print("Oh no the goose is dead")
			ready_to_interact = false
		2:
			print("Hooray the goose carries the player here")
			ready_to_interact = false
		3:
			print("Ignored, set a timer to allow goose interaction again in a few seconds")
			ready_to_interact = false
			waiting_to_interact = true
	dialogBox.visible = false
	


