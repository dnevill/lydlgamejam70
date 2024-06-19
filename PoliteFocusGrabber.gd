extends Button

# Called when the node enters the scene tree for the first time.
#func _ready():
#	if get_viewport().gui_get_focus_owner() == null:
#		self.grab_focus()






func _on_dialog_visibility_changed():
	if is_visible_in_tree():
		self.grab_focus()
