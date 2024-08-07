extends Node3D

@export var onhit_damage:float = 10
@export var multiple_hits:bool = true
@export var hit_cooldown_seconds:float = 0.15

@export var explosion_time_seconds:float = 0.15
@export var max_explosion_radius:float = 5

#@onready var explosionHitboxShape = $ExplosionHitbox/CollisionShape3D

func _ready():
	var animation:Animation = prepare_animation()

func prepare_animation():
	#explosionHitboxShape.shape = SphereShape3D.new()
	var tween = create_tween()
	var radius_to_scale = 0.5 * (max_explosion_radius * 2)
	var max_scale = Vector3(radius_to_scale, radius_to_scale, radius_to_scale)
	tween.tween_property(self, "scale", max_scale, explosion_time_seconds).from_current()
	var ttlTimer = Timer.new()
	add_child(ttlTimer)
	ttlTimer.wait_time = explosion_time_seconds
	ttlTimer.one_shot = true
	ttlTimer.connect("timeout", self.queue_free)
	ttlTimer.start()


func _process(delta):
	pass
