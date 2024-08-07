extends Marker3D

var camera_sens = 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("camera_move_up"):
		self.position.y = self.position.y + camera_sens
	if Input.is_action_pressed("camera_move_down"):
		self.position.y = self.position.y - camera_sens
	if Input.is_action_pressed("camera_move_left"):
		self.position.z = self.position.z - camera_sens
	if Input.is_action_pressed("camera_move_right"):
		self.position.z = self.position.z + camera_sens
	if Input.is_action_pressed("camera_move_forward"):
		self.position.x = self.position.x + camera_sens
	if Input.is_action_pressed("camera_move_backward"):
		self.position.x = self.position.x - camera_sens
