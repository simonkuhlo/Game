extends CharacterBody3D

class_name SpellInstance

@onready var spell:Spell
@onready var caster:Entity
@onready var animation_player = $AnimationPlayer
@export var explosion:PackedScene


func _ready():
	#ttl = time to live
	var ttlTimer = Timer.new()
	add_child(ttlTimer)
	ttlTimer.wait_time = spell.secondsToLive
	ttlTimer.one_shot = true
	ttlTimer.connect("timeout", self.endSpell)
	ttlTimer.start()
	if animation_player.has_animation("RESET"):
		animation_player.play("RESET")
	if animation_player.has_animation("fly_forward"):
		animation_player.play("fly_forward")

func _physics_process(delta):
	move(delta)

func onHit(object):
	if object is Entity:
		object.health = object.health - spell.damage
	endSpell()

func move(delta):
	velocity = (transform.basis * Vector3.FORWARD).normalized() * delta * spell.projectileSpeed
	move_and_slide()
	if get_slide_collision_count() > 0:
		endSpell()

func endSpell():
	var explosion_instance = explosion.duplicate().instantiate()
	explosion_instance.transform = self.global_transform
	explosion_instance.onhit_damage = self.spell.damage
	get_tree().root.add_child(explosion_instance)
	queue_free()
