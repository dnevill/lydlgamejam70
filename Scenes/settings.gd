extends Control


var mainMenuSCN = preload("res://Scenes/main_menu.tscn");
var waitingForKeybindInput = false
var action_waiting_to_bind = ""
var button_waiting_to_bind : Button = null
var action_to_check1 = ""
var action_to_check2 = ""
var button_waiting_for_focus : Button = null

func _ready():
	if PlayerStateManager.enable_curvature:
		$curvebutton.text = "Enabled"
	else:
		$curvebutton.text = "Disabled"
	$jumpbutton.grab_focus()
	var index = AudioServer.get_bus_index("SFX")
	var linearsound = db_to_linear(AudioServer.get_bus_volume_db(index))
	$sfxSlider.value = linearsound
	var indexmus = AudioServer.get_bus_index("Music")
	var linearsoundMus = db_to_linear(AudioServer.get_bus_volume_db(indexmus))
	$musicSlider.value = linearsoundMus

func _input(event):
	if (event is InputEventKey or event is InputEventJoypadButton) and waitingForKeybindInput:
		button_waiting_to_bind.release_focus()
		button_waiting_for_focus = button_waiting_to_bind
		var keycode
		if event is InputEventKey: keycode = OS.get_keycode_string(DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode))
		elif event is InputEventJoypadButton: keycode = event.as_text()
		#print(OS.get_keycode_string(keycode) + " is now being bound to " + action_waiting_to_bind)
		if button_waiting_to_bind != null:
			button_waiting_to_bind.text = keycode
		InputMap.action_add_event(action_waiting_to_bind, event)
		if InputMap.action_has_event(action_to_check1, event):
			InputMap.action_erase_event(action_to_check1, event)
			#print(OS.get_keycode_string(keycode) + " is being removed from " + action_to_check1)
		if InputMap.action_has_event(action_to_check2, event):
			InputMap.action_erase_event(action_to_check2, event)
			#print(OS.get_keycode_string(keycode) + " is being removed from " + action_to_check2)
		button_waiting_to_bind.disabled = false
		action_waiting_to_bind = ""
		button_waiting_to_bind = null
		waitingForKeybindInput = false
		$ReturnFocusTimer.start()
	elif event.is_action("ui_cancel"):
		go_back()

func go_back():
	get_tree().change_scene_to_packed(mainMenuSCN);

func _on_back_pressed():
	go_back();

func _on_texture_button_pressed():
	go_back();

func _on_jumpbutton_pressed():
	if not waitingForKeybindInput:
		waitingForKeybindInput = true
		action_waiting_to_bind = "foxy_jump_accept"
		action_to_check1 = "foxy_left"
		action_to_check2 = "foxy_right"
		button_waiting_to_bind = $jumpbutton
		button_waiting_to_bind.disabled = true
		button_waiting_to_bind.text = "??"


func _on_leftbutton_pressed():
	if not waitingForKeybindInput:
		waitingForKeybindInput = true
		action_waiting_to_bind = "foxy_left"
		action_to_check1 = "foxy_jump_accept"
		action_to_check2 = "foxy_right"
		button_waiting_to_bind = $leftbutton
		button_waiting_to_bind.disabled = true
		button_waiting_to_bind.text = "??"


func _on_rightbutton_pressed():
	if not waitingForKeybindInput:
		waitingForKeybindInput = true
		action_waiting_to_bind = "foxy_right"
		action_to_check1 = "foxy_left"
		action_to_check2 = "foxy_jump_accept"
		button_waiting_to_bind = $rightbutton
		button_waiting_to_bind.disabled = true
		button_waiting_to_bind.text = "??"


func _on_sfx_slider_value_changed(value):
	var index = AudioServer.get_bus_index("SFX")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(index,db)
	#print(str(index) + " is for SFX and " + str(value) + " converts to " + str(db))
	$ExampleSFX.play()


func _on_music_slider_value_changed(value):
	var index = AudioServer.get_bus_index("Music")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(index,db)
	#print(str(index) + " is for Music and " + str(value) + " converts to " + str(db))


func _on_curvebutton_pressed():
	PlayerStateManager.enable_curvature = not PlayerStateManager.enable_curvature
	if PlayerStateManager.enable_curvature:
		$curvebutton.text = "Enabled"
	else:
		$curvebutton.text = "Disabled"


func _on_return_focus_timer_timeout():
	button_waiting_for_focus.grab_focus()
