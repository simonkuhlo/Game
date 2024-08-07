extends Camera3D

@export var zoom_sensitivity = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hi from Camera_1")
	self.current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		self.position.z = self.position.z - zoom_sensitivity
	if Input.is_action_just_pressed("camera_zoom_out"):
		self.position.z = self.position.z + zoom_sensitivity
