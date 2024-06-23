extends Control


var mainMenuSCN = preload("res://Scenes/main_menu.tscn");
var waitingForKeybindInput = false
var action_waiting_to_bind = ""
var button_waiting_to_bind : Button = null
var action_to_check1 = ""
var action_to_check2 = ""



func _input(event):
	if event is InputEventKey and waitingForKeybindInput:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		print(OS.get_keycode_string(keycode) + " is now being bound to " + action_waiting_to_bind)
		if button_waiting_to_bind != null:
			button_waiting_to_bind.text = OS.get_keycode_string(keycode)
		InputMap.action_add_event(action_waiting_to_bind, event)
		if InputMap.action_has_event(action_to_check1, event):
			InputMap.action_erase_event(action_to_check1, event)
			print(OS.get_keycode_string(keycode) + " is being removed from " + action_to_check1)
		if InputMap.action_has_event(action_to_check2, event):
			InputMap.action_erase_event(action_to_check2, event)
			print(OS.get_keycode_string(keycode) + " is being removed from " + action_to_check2)
		waitingForKeybindInput = false
		action_waiting_to_bind = ""
		button_waiting_to_bind = null

func go_back():
	get_tree().change_scene_to_packed(mainMenuSCN);

func _on_back_pressed():
	go_back();

func _on_texture_button_pressed():
	go_back();

func _on_jumpbutton_pressed():
	waitingForKeybindInput = true
	action_waiting_to_bind = "foxy_jump_accept"
	action_to_check1 = "foxy_left"
	action_to_check2 = "foxy_right"
	button_waiting_to_bind = $jumpbutton


func _on_leftbutton_pressed():
	waitingForKeybindInput = true
	action_waiting_to_bind = "foxy_left"
	action_to_check1 = "foxy_jump_accept"
	action_to_check2 = "foxy_right"
	button_waiting_to_bind = $leftbutton


func _on_rightbutton_pressed():
	waitingForKeybindInput = true
	action_waiting_to_bind = "foxy_right"
	action_to_check1 = "foxy_left"
	action_to_check2 = "foxy_jump_accept"
	button_waiting_to_bind = $rightbutton


func _on_sfx_slider_value_changed(value):
	var index = AudioServer.get_bus_index("SFX")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(index,db)
	print(str(index) + " is for SFX and " + str(value) + " converts to " + str(db))


func _on_music_slider_value_changed(value):
	var index = AudioServer.get_bus_index("Music")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(index,db)
	print(str(index) + " is for Music and " + str(value) + " converts to " + str(db))
