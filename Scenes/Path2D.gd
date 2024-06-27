extends Path2D

@onready var timer = $"../Timer"
var anim_timer_end_point
var timer_start_time
var we_animate
var change_to_star
var done_changing
# Called when the node enters the scene tree for the first time.
func _ready():
	change_to_star = false
	done_changing = false
	anim_timer_end_point = timer.wait_time * 0.2
	timer_start_time = timer.wait_time
	$PathFollow2D.progress_ratio = 0
	we_animate = (PlayerStateManager.OxFate == PlayerStateManager.OxFates.RELEASED) and PlayerStateManager.cycleNum == 3
	if (PlayerStateManager.OxFate == PlayerStateManager.OxFates.RELEASED) and PlayerStateManager.cycleNum == 4:
		$PathFollow2D.progress_ratio = 1
		$PathFollow2D/OxAnimated.play("star_pulse", 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if we_animate:
		if not change_to_star:
			var ratio = 1 - max(0, timer.time_left - anim_timer_end_point) / timer_start_time
			#print(str(timer.time_left) + " - " + str(anim_timer_end_point) + " / " + str(timer_start_time) + " = " + str(ratio) )
			$PathFollow2D.progress_ratio = ratio
			if ratio >= 1: change_to_star = true
		elif not done_changing:
			$PathFollow2D/OxAnimated.play("star_pulse")
			done_changing = true
