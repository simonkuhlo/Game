extends Entity

class_name Player

@export var BASE_SPEED:float = 7
@export var JUMP_VELOCITY:float = 5.5
@export var MOUSE_SENSITIVITY:float = 0.01
@export var camera_rig:PackedScene = preload("res://World/Camera/v1/following_camera.tscn")
@export var current_spell:Spell

@onready var cursor = %PlayerCursor
@onready var spellcast_origin = %SpellcastOrigin

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var actual_speed:float = BASE_SPEED

func _ready():
	current_spell = current_spell.duplicate(true)
	var camera_rig_instance = camera_rig.instantiate()
	camera_rig_instance.following = self
	get_tree().root.add_child.call_deferred(camera_rig_instance)

func _physics_process(delta):
	look_at_cursor()
	handle_movement(delta)
	if Input.is_action_just_pressed("cast_spell"):
		var spell_instance:SpellInstance = current_spell.duplicate(true).scene.instantiate()
		spell_instance.spell = current_spell.duplicate()
		spell_instance.transform = spellcast_origin.global_transform
		spell_instance.caster = self
		get_tree().root.add_child(spell_instance)

func look_at_cursor():
	var camera = get_viewport().get_camera_3d()
	if camera:
		var playerPosition = self.global_transform.origin
		var dropPlane = Plane(Vector3(0, 1, 0), playerPosition.y)
		var rayLength = 1000
		var mousePos = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var cursorPosition = dropPlane.intersects_ray(from, to)
		if cursorPosition:
			cursor.global_transform.origin = cursorPosition
			look_at(cursorPosition, Vector3.UP)

func handle_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("sprint"):
		actual_speed = BASE_SPEED * 2
	else:
		actual_speed = BASE_SPEED
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * actual_speed
		velocity.z = direction.z * actual_speed
	else:
		velocity.x = move_toward(velocity.x, 0, actual_speed)
		velocity.z = move_toward(velocity.z, 0, actual_speed)
	move_and_slide()
