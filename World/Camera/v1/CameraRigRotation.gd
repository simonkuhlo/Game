extends Marker3D

var camera_rotation_speed = 50
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("camera_rotate_left"):
		self.rotate_y(deg_to_rad(-camera_rotation_speed * delta)) 
	if Input.is_action_pressed("camera_rotate_right"):
		self.rotate_y(deg_to_rad(camera_rotation_speed * delta)) 
