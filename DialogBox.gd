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

func Reveal():
	#update_text_scale()
	update_text_scale_target($DialogBoxContainer/DialogText)
	visible = true
	$DialogBoxContainer/Options/ButtonOption3.grab_focus()
	$DialogBoxContainer/Options/ButtonOption2.grab_focus()
	$DialogBoxContainer/Options/ButtonOption1.grab_focus()

func update_text_scale():
	var font_size = $DialogBoxContainer/DialogText.get_theme_font_size("normal_font_size")
	while $DialogBoxContainer/DialogText.get_content_height() < $DialogBoxContainer/DialogText.size.y and font_size < 96:
		if(PlayerStateManager.DEBUG):
			print("growin" + str($DialogBoxContainer/DialogText.get_content_height()) + "," + str($DialogBoxContainer/DialogText.size.y) + "," + str(font_size))
		font_size += 1
		$DialogBoxContainer/DialogText.add_theme_font_size_override("normal_font_size", font_size)
	while $DialogBoxContainer/DialogText.get_content_height() > $DialogBoxContainer/DialogText.size.y and font_size > 8:
		if(PlayerStateManager.DEBUG):
			print("shrinkin" + str($DialogBoxContainer/DialogText.get_content_height()) + "," + str($DialogBoxContainer/DialogText.size.y) + "," + str(font_size))
		font_size -= 1
		$DialogBoxContainer/DialogText.add_theme_font_size_override("normal_font_size", font_size)



func update_text_scale_target(labelname):
	var font_size = labelname.get_theme_font_size("normal_font_size")
	while labelname.get_content_height() < labelname.size.y and font_size < 96:
		if(PlayerStateManager.DEBUG):
			print("growin" + str(labelname.get_content_height()) + "," + str(labelname.size.y) + "," + str(font_size))
		font_size += 1
		labelname.add_theme_font_size_override("normal_font_size", font_size)
	while labelname.get_content_height() > labelname.size.y and font_size > 8:
		if(PlayerStateManager.DEBUG):
			print("shrinkin" + str(labelname.get_content_height()) + "," + str(labelname.size.y) + "," + str(font_size))
		font_size -= 1
		labelname.add_theme_font_size_override("normal_font_size", font_size)

signal option_selected(optionNumber : int)

func _on_button_option_1_pressed():
	option_selected.emit(1)

func _on_button_option_2_pressed():
	option_selected.emit(2)

func _on_button_option_3_pressed():
	option_selected.emit(3)
