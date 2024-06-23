extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready():
	progress_ratio = randf()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	progress += randi_range(0,2)

