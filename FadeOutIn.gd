class_name Fader extends Control

signal done_fading_in
signal done_fading_out


func FadeOut():
	visible = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	emit_signal("done_fading_out")


func FadeIn():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	emit_signal("done_fading_in")
	visible = false
