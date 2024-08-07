extends Node3D

class_name CameraRig


@export var following:Node3D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if following:
		self.position = following.position
