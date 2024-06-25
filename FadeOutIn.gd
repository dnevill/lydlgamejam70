class_name Fader extends Control

signal done_fading_in
signal done_fading_out


func FadeOut():
	focus_mode = Control.FOCUS_ALL
	grab_focus()
	visible = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	emit_signal("done_fading_out")


func FadeIn():
	focus_mode = Control.FOCUS_NONE
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	emit_signal("done_fading_in")
	visible = false
