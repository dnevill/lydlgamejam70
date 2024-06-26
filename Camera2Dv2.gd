extends Camera2D
@onready var player_rigid_body = $"../PlayerRigidBody"

const LEFT_BOUNDS = 64;
const RIGHT_BOUNDS = 6688;
const LOWER_BOUNDS = -216;
const UPPER_BOUNDS = -448;

func _ready():
	pass;

func _process(_delta):
	# adjust position, within bounds
	self.position = player_rigid_body.position

