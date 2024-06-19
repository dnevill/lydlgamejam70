class_name DialogBox extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func SetDialogText(input_text : String):
	$DialogBoxContainer/DialogText.text = input_text

func SetOption1Text(input_text : String):
	$DialogBoxContainer/Options/ButtonOption1.text = input_text
	$DialogBoxContainer/Options/ButtonOption1.visible = true
func SetOption2Text(input_text : String):
	$DialogBoxContainer/Options/ButtonOption2.text = input_text
	$DialogBoxContainer/Options/ButtonOption2.visible = true
func SetOption3Text(input_text : String):
	$DialogBoxContainer/Options/ButtonOption3.text = input_text
	$DialogBoxContainer/Options/ButtonOption3.visible = true

func SetPhoto(input_texture : Texture):
	$NPCImage.texture = input_texture


signal option_selected(optionNumber : int)

func _on_button_option_1_pressed():
	option_selected.emit(1)

func _on_button_option_2_pressed():
	option_selected.emit(2)

func _on_button_option_3_pressed():
	option_selected.emit(3)
